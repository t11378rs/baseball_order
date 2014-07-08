#4.26に収束しないとシュミレータとして適切じゃない
#todo：データベースと連動させる
#2013年シュミレーションをやらせる

NUM_OF_MATCH = 144
scores=Array[0..NUM_OF_MATCH-1]


LAST_INING = 9

ONE_BASE_HIT = 1
TWO_BASE_HIT = 2
THREE_BASE_HIT = 3
HR = 4
BB = 0

SEIDO = 100000 #100だと百分率、1000だと千分率の精度で計算する

atbat_seed = 0

$raw_players = []
$players = []

$next_batter = 0 #打順は0番から8番まで と 9番から17番まで

#[name,PA,AB,h,2b,3b,hr,sb,cb,bb,sh,sf]
#(名前、打席、打数、ヒット、2B,3B,HR,盗塁成功,盗塁失敗、四死球（敬遠含む）、犠飛、犠打)
class Player
	def initialize(myname,myPA,myAB,myh,my2b,my3b,myhr,mysb,mycb,mybb,mysh,mysf)
    	@name = myname
    	@onbase_p = (myh+mybb)*SEIDO/myPA
    	@hr_p = myhr*SEIDO/myPA
    	@triple_p = my3b*SEIDO/myPA
    	@double_p = my2b*SEIDO/myPA
    	@single_p = (myh-my2b-my3b-myhr)*SEIDO/myPA
    	@bb_p = mybb*SEIDO/myPA
    	@sacrifice_p = (myPA-myAB-mybb)*SEIDO/myPA #厳密じゃないmysf使ったほうがいいけどだるかったし、てか使ってねえしまだ
    	@challengesb_p = (mysb+mycb)*SEIDO/(myh+mybb-my2b-my3b-myhr) #ヒット数とBB数を出塁機会にしている
    	@successsb_p = mysb*SEIDO/(mysb+mycb)

    	@pa = 0
    	@ab = 0
    	@h = 0
    	@double = 0
    	@triple = 0
    	@hr = 0
    	@sb = 0
    	@bb = 0
    	@sh = 0
    	@sf = 0
    	@unknown = 0
  	end

  	def printRecord()
  		hits = h + double + triple + hr
  		average = (hits.to_f/(pa-bb)).round(3)
  		string = name + ":\t" + average.to_s + "(" + pa.to_s + ")" + "\t" + hits.to_s + "\t" + double.to_s + "\t" + triple.to_s + "\t" + hr.to_s + "\t" + bb.to_s + "\t(unknown " + unknown.to_s + ")"
  		print string
  		puts ""
  	end

  	attr_reader :name, :onbase_p, :hr_p, :triple_p, :double_p, :single_p, :bb_p, :sacrifice_p, :challengesb_p, :successsb_p
  	attr_accessor :pa, :ab, :h, :double, :triple, :hr, :sb, :bb, :sh, :sf, :unknown
end

def update_runner(mybases,nbasehit)
	tmp_bases = [false,false,false]

	case nbasehit
	when BB
		if mybases[0]&&mybases[1]&&mybases[2] then #満塁
			tmp_bases = [true,true,true]
		elsif mybases[0]&&mybases[1] #1,2塁
			tmp_bases = [true,true,true]
		elsif mybases[0]&&mybases[2] #1,3塁
			tmp_bases = [true,true,true]
		elsif mybases[1]&&mybases[2] #2,3
			tmp_bases = [true,true,true]
		elsif mybases[0] #1
			tmp_bases = [true,true,false]
		elsif mybases[1] #2
			tmp_bases = [true,true,false]
		elsif mybases[2] #3
			tmp_bases = [true,false,true]
		else #ランナー無し
			tmp_bases = [true,false,false]
		end			
	when ONE_BASE_HIT
		tmp_bases[2]=mybases[1]
		tmp_bases[1]=mybases[0]
		tmp_bases[0]=true
	when TWO_BASE_HIT
		tmp_bases[2]=mybases[0]
		tmp_bases[1]=true
		tmp_bases[0]=false
	when THREE_BASE_HIT
		tmp_bases[2]=true
		tmp_bases[1]=false
		tmp_bases[0]=false
	when HR
		tmp_bases[2]=false
		tmp_bases[1]=false
		tmp_bases[0]=false
	end

	return tmp_bases
end




def scoring(old,newest)
	num_of_old = 0
	num_of_newest = 0

	old.each do |state|
		if state then 
			num_of_old += 1
		end
	end

	newest.each do |state|
		if state then 
			num_of_newest += 1
		end
	end

	if (num_of_old - num_of_newest) >= 0 then
		puts "we got " + (num_of_old - num_of_newest+1).to_s
		return (num_of_old - num_of_newest)+1
	else
		return 0
	end	
end





def simulate_half_ining
	tmp_score = 0
	outcount = 0
	bases = [false,false,false]
	updated_bases = [false,false,false]

	while outcount <3

		$players[$next_batter].pa += 1
		atbat_seed = rand(SEIDO) #0...99
		if atbat_seed > SEIDO-$players[$next_batter].onbase_p then #アウトじゃない時
			if atbat_seed > SEIDO-$players[$next_batter].hr_p then
				puts $players[$next_batter].name + ": HR!!!!"
				$players[$next_batter].hr += 1
				updated_bases = update_runner(bases,HR)			
			elsif atbat_seed > SEIDO - ($players[$next_batter].hr_p + $players[$next_batter].triple_p)  then
				puts $players[$next_batter].name + ": Triple!!!"
				$players[$next_batter].triple += 1
				updated_bases = update_runner(bases,THREE_BASE_HIT)
			elsif atbat_seed > SEIDO - ($players[$next_batter].hr_p + $players[$next_batter].triple_p + $players[$next_batter].double_p) then
				puts $players[$next_batter].name + ": Double!!"
				$players[$next_batter].double += 1
				updated_bases = update_runner(bases,TWO_BASE_HIT)
			elsif atbat_seed > SEIDO - ($players[$next_batter].hr_p + $players[$next_batter].triple_p + $players[$next_batter].double_p + $players[$next_batter].single_p) then
				puts $players[$next_batter].name + ": Single!"
				$players[$next_batter].h += 1
				updated_bases = update_runner(bases,ONE_BASE_HIT)
			elsif atbat_seed > SEIDO - ($players[$next_batter].hr_p + $players[$next_batter].triple_p + $players[$next_batter].double_p + $players[$next_batter].single_p + $players[$next_batter].bb_p) then
				puts $players[$next_batter].name + ": BB or HitByPitch"
				$players[$next_batter].bb += 1
				updated_bases = update_runner(bases,BB)
			else#なんかよくわかんないけど余っちゃった時もSingle
				puts $players[$next_batter].name + ": Single?"
				$players[$next_batter].unknown += 1
				updated_bases = update_runner(bases,ONE_BASE_HIT)
			end
			tmp_score += scoring(bases,updated_bases)
			bases = updated_bases
		else #アウトの時
			puts $players[$next_batter].name + ": out..."
			outcount +=1
		end

		#打順を回す
		$next_batter += 1
		if $next_batter>8 then
			$next_batter = 0
		end
	end

	puts "filaly... we got " + tmp_score.to_s

	return tmp_score
end

#選手データの作成
puts "making players..."


=begin
#2014
$players[0] = Player.new("#06 Sakamoto", 620.0, 554.0, 147.0, 33.0, 1.0, 12.0, 24.0, 4.0, 55.0+1+4, 4.0, 3.0)
$players[1] = Player.new("#08 Kataoka", 300.0, 259.0, 75.0, 5.0, 0.0, 4.0, 9.0, 1.0, 24.0+2+0, 15.0, 0.0)
$players[2] = Player.new("#07 Chono", 642.0, 590.0, 166.0, 21.0, 3.0, 19.0, 14.0, 5.0, 48.0+1+0, 3.0, 0.0)
$players[3] = Player.new("#25 Murata", 595.0, 519.0, 164.0, 26.0, 0.0, 25.0, 1.0, 1.0, 50.0+13+1, 6.0, 7.0)
$players[4] = Player.new("#10 Abe", 529.0, 422.0, 125.0, 17.0, 0.0, 32.0, 0.0, 0.0, 86.0+15+9, 0.0, 6.0)
$players[5] = Player.new("#05 Lopez", 467.0, 429.0, 130.0, 26.0, 0.0, 18.0, 1.0, 1.0, 25.0+5+1, 5.0, 3.0)
$players[6] = Player.new("#42 Anderson", 56.0, 53.0, 17.0, 3.0, 0.0, 1.0, 0.0, 0.0, 2, 0.0, 0.0)
$players[7] = Player.new("#32 Hashimoto", 111.0, 92.0, 22.0, 3.0, 1.0, 1.0, 3.0, 3.0, 7.0+1+0, 10.0, 1.0)
$players[8] = Player.new("#19 Sugano", 50.0, 50.0, 5.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0)
=end

#2013
#[name,PA,AB,h,2b,3b,hr,sb,cb,bb,sh,sf]
$players[0] = Player.new("#07 Chono", 642.0, 590.0, 166.0, 21.0, 3.0, 19.0, 14.0, 5.0, 48.0+1+0, 3.0, 0.0)
$players[1] = Player.new("#00 Terauchi", 274.0, 240.0, 54.0, 5.0, 1.0, 2.0, 6.0, 2.0, 11.0+2+0, 21.0, 0.0)
$players[2] = Player.new("#06 Sakamoto", 620.0, 554.0, 147.0, 33.0, 1.0, 12.0, 24.0, 4.0, 55.0+1+4, 4.0, 3.0)
$players[3] = Player.new("#10 Abe", 529.0, 422.0, 125.0, 17.0, 0.0, 32.0, 0.0, 0.0, 86.0+15+9, 0.0, 6.0)
$players[4] = Player.new("#05 Lopez", 467.0, 429.0, 130.0, 26.0, 0.0, 18.0, 1.0, 1.0, 25.0+5+1, 5.0, 3.0)
$players[5] = Player.new("#25 Murata", 595.0, 519.0, 164.0, 26.0, 0.0, 25.0, 1.0, 1.0, 50.0+13+1, 6.0, 7.0)
$players[6] = Player.new("#42 Bowker", 295.0, 271.0, 71.0, 17.0, 3.0, 14.0, 0.0, 0.0, 19.0+3+0, 0.0, 2.0)
$players[7] = Player.new("#61 Nakai", 149.0, 139.0, 45.0, 6.0, 0.0, 4.0, 2.0, 1.0, 8.0+0+0, 2.0, 0.0)
$players[8] = Player.new("#26 Utsumi", 47.0, 40.0, 2.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0+0+0, 0.0, 0.0)


for i in 0...NUM_OF_MATCH
	puts "===== PLAY BALL! ====="

	$score_of_top = 0
	$next_batter = 0

	for ining in 1...LAST_INING+1
		puts "GGGGG  top of " + ining.to_s + "th GGGGG"
		$score_of_top += simulate_half_ining()
	end

	scores[i] = $score_of_top

	puts "===== " + $score_of_top.to_s + " ====="
	puts "===== GAME! ====="
	puts ""
	puts ""

end

puts ""

sum=0.0
average=0.0
scores.each do |score|
  sum += score
  average = sum/scores.size
end

print "=================RESULT=================\n\n"

print "#XX name:\tave(pa)\t\thits\tdoubles\ttriples\thrs\tbbs\t(unknowns) \n" 
$players.each do |player|
	player.printRecord
end
puts ""
print "average score: " + average.round(3).to_s + " (points)\n\n"
print "==================DONE=================\n\n"

