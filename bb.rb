NUM_OF_MATCH = 100000

LAST_INING = 12

ONE_BASE_HIT = 1
TWO_BASE_HIT = 2
THREE_BASE_HIT = 3
HR = 4
BB = 0

TOP = 0
BOTTOM = 1

atbat_seed = 0

$raw_players = []
$players = []

$next_batter=[0,9] #打順は0番から8番まで と 9番から17番まで

won=0
lose=0
draw=0

#raw_player data
#[名前、打席、打数、ヒット、2B,3B,HR,盗塁成功,盗塁失敗、四死球（敬遠含む）、犠飛、犠打]
#[name,PA,AB,h,2b,3b,hr,sb,cb,bb,sh,sf]

$raw_players[0] = {"name"=>"#06 Sakamoto ", "pa"=>620.0, "ab"=>554.0, "hit"=>147.0, "double"=>33.0, "triple"=>1.0, "hr"=>12.0, "sb"=>24.0, "cb"=>4.0, "bb"=>55.0+1+4, "sh"=>4.0, "sf"=>3.0}
$raw_players[2] = {"name"=>"#07 Chono", "pa"=>642.0, "ab"=>590.0, "hit"=>166.0, "double"=>21.0, "triple"=>3.0, "hr"=>19.0, "sb"=>14.0, "cb"=>5.0, "bb"=>48.0+1+0, "sh"=>3.0, "sf"=>0.0}
$raw_players[4] = {"name"=>"#10 Abe", "pa"=>529.0, "ab"=>422.0, "hit"=>125.0, "double"=>17.0, "triple"=>0.0, "hr"=>32.0, "sb"=>0.0, "cb"=>0.0, "bb"=>86.0+15+9, "sh"=>0.0, "sf"=>6.0}
$raw_players[3] = {"name"=>"#25 Murata", "pa"=>595.0, "ab"=>519.0, "hit"=>164.0, "double"=>26.0, "triple"=>0.0, "hr"=>25.0, "sb"=>1.0, "cb"=>1.0, "bb"=>50.0+13+1, "sh"=>6.0, "sf"=>7.0}
$raw_players[1] = {"name"=>"#08 Kataoka", "pa"=>300.0, "ab"=>259.0, "hit"=>75.0, "double"=>5.0, "triple"=>0.0, "hr"=>4.0, "sb"=>9.0, "cb"=>1.0, "bb"=>24.0+2+0, "sh"=>15.0, "sf"=>0.0}
$raw_players[5] = {"name"=>"#05 Lopez", "pa"=>467.0, "ab"=>429.0, "hit"=>130.0, "double"=>26.0, "triple"=>0.0, "hr"=>18.0, "sb"=>1.0, "cb"=>1.0, "bb"=>25.0+5+1, "sh"=>5.0, "sf"=>3.0}
$raw_players[6] = {"name"=>"#42 Anderson", "pa"=>56.0, "ab"=>53.0, "hit"=>17.0, "double"=>3.0, "triple"=>0.0, "hr"=>1.0, "sb"=>0.0, "cb"=>0.0, "bb"=>2, "sh"=>0.0, "sf"=>0.0}
#$raw_players[7] = {"name"=>"#24 Takahashi", "pa"=>197.0, "ab"=>165.0, "hit"=>50.0, "double"=>6.0, "triple"=>1.0, "hr"=>10.0, "sb"=>0.0, "cb"=>0.0, "bb"=>31.0+1+2, "sh"=>0.0, "sf"=>0.0}
$raw_players[7] = {"name"=>"#32 Hashimoto", "pa"=>111.0, "ab"=>92.0, "hit"=>22.0, "double"=>3.0, "triple"=>1.0, "hr"=>1.0, "sb"=>3.0, "cb"=>3.0, "bb"=>7.0+1+0, "sh"=>10.0, "sf"=>1.0}
$raw_players[8] = {"name"=>"#19 Sugano", "pa"=>50.0, "ab"=>50.0, "hit"=>5.0, "double"=>1.0, "triple"=>0.0, "hr"=>0.0, "sb"=>0.0, "cb"=>0.0, "bb"=>0, "sh"=>0.0, "sf"=>0.0}

#$raw_players[9] =  {"name"=>"#04 Uemoto", "pa"=>70.0, "ab"=>59.0, "hit"=>15.0, "double"=>3.0, "triple"=>0.0, "hr"=>2.0, "sb"=>2.0, "cb"=>1.0, "bb"=>8.0+1+0, "sh"=>2.0, "sf"=>0.0}
$raw_players[9] =  {"name"=>"#01 Toritani", "pa"=>643.0, "ab"=>532.0, "hit"=>150.0, "double"=>30.0, "triple"=>4.0, "hr"=>10.0, "sb"=>15.0, "cb"=>7.0, "bb"=>104.0+4+1, "sh"=>1.0, "sf"=>2.0}
$raw_players[10] = {"name"=>"#00 Yamato", "pa"=>454.0, "ab"=>384.0, "hit"=>105.0, "double"=>12.0, "triple"=>3.0, "hr"=>0.0, "sb"=>19.0, "cb"=>9.0, "bb"=>27.0+8+0, "sh"=>35.0, "sf"=>0.0}
$raw_players[11] = {"name"=>"#07 Nishioka", "pa"=>692.0, "ab"=>596.0, "hit"=>206.0, "double"=>32.0, "triple"=>8.0, "hr"=>11.0, "sb"=>22.0, "cb"=>11.0, "bb"=>79.0+4+1, "sh"=>8.0, "sf"=>5.0}
$raw_players[12] = {"name"=>"#05 Gomez", "pa"=>15.0, "ab"=>14.0, "hit"=>2.0, "double"=>1.0, "triple"=>0.0, "hr"=>0.0, "sb"=>0.0, "cb"=>0.0, "bb"=>1.0, "sh"=>0.0, "sf"=>0.0}
$raw_players[13] = {"name"=>"#09 Murton", "pa"=>613.0, "ab"=>566.0, "hit"=>178.0, "double"=>37.0, "triple"=>1.0, "hr"=>19.0, "sb"=>6.0, "cb"=>1.0, "bb"=>42.0+1+1, "sh"=>0.0, "sf"=>4.0}
$raw_players[14] = {"name"=>"#49 Imanari", "pa"=>215.0, "ab"=>185.0, "hit"=>49.0, "double"=>10.0, "triple"=>2.0, "hr"=>1.0, "sb"=>2.0, "cb"=>2.0, "bb"=>25.0+0+0, "sh"=>1.0, "sf"=>4.0}
$raw_players[15] = {"name"=>"#09 Fukudome", "pa"=>241.0, "ab"=>212.0, "hit"=>79.0, "double"=>22.0, "triple"=>0.0, "hr"=>13.0, "sb"=>5.0, "cb"=>2.0, "bb"=>69.0+6+3, "sh"=>0.0, "sf"=>4.0}
$raw_players[16] = {"name"=>"#09 Shimizu", "pa"=>94.0, "ab"=>90.0, "hit"=>21.0, "double"=>3.0, "triple"=>1.0, "hr"=>0.0, "sb"=>6.0, "cb"=>1.0, "bb"=>1.0, "sh"=>1.0, "sf"=>0.0}
$raw_players[17] = {"name"=>"#09 Noumi", "pa"=>50.0, "ab"=>50.0, "hit"=>5.0, "double"=>1.0, "triple"=>0.0, "hr"=>0.0, "sb"=>0.0, "cb"=>0.0, "bb"=>0, "sh"=>0.0, "sf"=>0.0}

#$raw_players[13] = {"name"=>"#25 AraiTaka", "pa"=>548.0, "ab"=>476.0, "hit"=>127.0, "double"=>20.0, "triple"=>0.0, "hr"=>15.0, "sb"=>2.0, "cb"=>3.0, "bb"=>60.0+5+3, "sh"=>0.0, "sf"=>7.0}
#$raw_players[14] = {"name"=>"#51 Itou", "pa"=>71.0, "ab"=>62.0, "hit"=>9.0, "double"=>1.0, "triple"=>0.0, "hr"=>1.0, "sb"=>0.0, "cb"=>2.0, "bb"=>6.0+1+0, "sh"=>2.0, "sf"=>0.0}
#$raw_players[15] = {"name"=>"#33 Nishida", "pa"=>21.0, "ab"=>20.0, "hit"=>5.0, "double"=>0.0, "triple"=>0.0, "hr"=>0.0, "sb"=>0.0, "cb"=>0.0, "bb"=>1.0, "sh"=>0.0, "sf"=>0.0}
#$raw_players[16] = {"name"=>"#44 Umeno", "pa"=>26.0, "ab"=>26.0, "hit"=>6.0, "double"=>3.0, "triple"=>1.0, "hr"=>0.0, "sb"=>0.0, "cb"=>0.0, "bb"=>0.0, "sh"=>0.0, "sf"=>0.0}
#$raw_players[17] = {"name"=>"#65 Ogata", "pa"=>21.0, "ab"=>20.0, "hit"=>5.0, "double"=>1.0, "triple"=>0.0, "hr"=>0.0, "sb"=>2.0, "cb"=>1.0, "bb"=>0.0+0.0+1.0, "sh"=>0.0, "sf"=>0.0}

#player data
#[name,work%,hr%,3b%,2b%,1b%,bb&hbp%,sacrifice_and_others,clallengesb%,successsb%]
def make_player(raw_player)
	player = {"name"=>raw_player["name"], 
			  "onbase"=>(raw_player["hit"]+raw_player["bb"])*100/raw_player["pa"],
			  "hr"=>raw_player["hr"]*100/raw_player["pa"], 
			  "triple"=>raw_player["triple"]*100/raw_player["pa"],
			  "double"=>raw_player["double"]*100/raw_player["pa"],
			  "single"=>(raw_player["hit"]-raw_player["double"]-raw_player["triple"]-raw_player["hr"])*100/raw_player["pa"],
			  "bb"=>raw_player["bb"]*100/raw_player["pa"],
			  "hr"=>raw_player["hr"]*100/raw_player["pa"],
			  "sacrifice"=>(raw_player["pa"]-raw_player["ab"]-raw_player["bb"])*100/raw_player["pa"],
			  "challengesb"=>(raw_player["sb"]+raw_player["cb"])*100/(raw_player["hit"]-raw_player["double"]-raw_player["triple"]-raw_player["hr"]),
			  "successsb"=>raw_player["sb"]*100/(raw_player["sb"]+raw_player["cb"])
			  }

	return player
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





def simulate_half_ining(t_or_b)
	tmp_score = 0
	outcount = 0
	bases = [false,false,false]
	updated_bases = [false,false,false]

	while outcount <3

		atbat_seed = rand(100) #0...99
		if atbat_seed > 100-$players[$next_batter[t_or_b]]["onbase"] then #アウトじゃない時
			if atbat_seed > 100-$players[$next_batter[t_or_b]]["hr"] then
				puts $players[$next_batter[t_or_b]]["name"] + ": HR!!!!"
				updated_bases = update_runner(bases,HR)			
			elsif atbat_seed > 100-($players[$next_batter[t_or_b]]["hr"]+$players[$next_batter[t_or_b]]["triple"])  then
				puts $players[$next_batter[t_or_b]]["name"] + ": Triple!!!"
				updated_bases = update_runner(bases,THREE_BASE_HIT)
			elsif atbat_seed > 100-($players[$next_batter[t_or_b]]["hr"]+$players[$next_batter[t_or_b]]["triple"]+$players[$next_batter[t_or_b]]["double"]) then
				puts $players[$next_batter[t_or_b]]["name"] + ": Double!!"
				updated_bases = update_runner(bases,TWO_BASE_HIT)
			elsif atbat_seed > 100-($players[$next_batter[t_or_b]]["hr"]+$players[$next_batter[t_or_b]]["triple"]+$players[$next_batter[t_or_b]]["double"]+$players[$next_batter[t_or_b]]["single"]) then
				puts $players[$next_batter[t_or_b]]["name"] + ": Single!"
				updated_bases = update_runner(bases,ONE_BASE_HIT)
			elsif atbat_seed > 100-($players[$next_batter[t_or_b]]["hr"]+$players[$next_batter[t_or_b]]["triple"]+$players[$next_batter[t_or_b]]["double"]+$players[$next_batter[t_or_b]]["single"]+$players[$next_batter[t_or_b]]["bb"]) then
				puts $players[$next_batter[t_or_b]]["name"] + ": BB or HitByPitch"
				updated_bases = update_runner(bases,BB)
			else#なんかよくわかんないけど余っちゃった時もSingle
				puts $players[$next_batter[t_or_b]]["name"] + ": Single?"
				updated_bases = update_runner(bases,ONE_BASE_HIT)
			end
			tmp_score += scoring(bases,updated_bases)
			bases = updated_bases
		else #アウトの時
			puts $players[$next_batter[t_or_b]]["name"] + ": out..."
			outcount +=1
		end

		#打順を回す
		$next_batter[t_or_b] += 1

		case t_or_b
		when TOP
			if $next_batter[t_or_b]>8 then
				$next_batter[t_or_b] = 0
			end
		when BOTTOM
			if $next_batter[t_or_b]>8+9 then
				$next_batter[t_or_b] = 9
			end
		end
	end

	puts "filaly... we got " + tmp_score.to_s

	return tmp_score
end

#選手データの作成
puts "making players..."
$raw_players.each do |player|
	$players.push make_player(player)
end

for i in 0...NUM_OF_MATCH
	puts "===== PLAY BALL! ====="

	$score_of_top = 0
	$score_of_bottom = 0

	for ining in 1...LAST_INING+1 #通常
		if (ining>=10 && $score_of_top!=$score_of_bottom) then
			puts "OoOoO No Cross OoOoO"
			puts ""
			break
		else
			puts "GGGGG  top of " + ining.to_s + "th GGGGG"
			$score_of_top += simulate_half_ining(TOP)
		end

		if (ining>=9 && $score_of_top<$score_of_bottom) then #裏は特殊
			puts "TTTTT bottom of " + ining.to_s + "th TTTTT"
			puts "XxXxX Cross XxXxX"
			puts ""
			break
		else
			puts "TTTTT bottom of " + ining.to_s + "th TTTTT"
			$score_of_bottom += simulate_half_ining(BOTTOM)
		end

		puts ""
	end

	puts "the filal score is... " + $score_of_top.to_s + " G-T " + $score_of_bottom.to_s

	if $score_of_top == $score_of_bottom then
		draw += 1
	elsif $score_of_top > $score_of_bottom then
		won += 1
	else
		lose += 1
	end
	
	puts "===== GAME! ====="
	puts ""
	puts ""

end


puts "giats' wining% is " + (won*100/(won+lose)).to_s + "%"
puts "won:" + won.to_s + " lose:" + lose.to_s + " draw:" + draw.to_s

