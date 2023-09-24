#!/bin/bash

pass="jirka"

read -sp 'Zadejte heslo: ' input
echo 
if [ $pass = $input ]
then

echo "To stop type 'stop'"
echo

#00 = SS
#01 = seed
#02 = sun
#03 = sumo
#04 = sierra
#05 = seal
#06 = Switch
#07 = sky/007
#08 = safe
#09 = soap
#010 = toes
#011 = tits
#012 = Tin_Tin
#013 = Jirka/tomb
#014 = ruzovy_Thor
#015 = tail
#016 = Tasha_Lem
#017 = tic-tac
#018 = TV
#019 = Toby
#020 = nose
#021 = net
#022 = nun
#023 = Nemo
#024 = Nero/Verca
#025 = nail
#026 = nacho
#027 = neck
#028 = knife
#029 = noob
#030 = mouse
#031 = Matt Smith
#032 = moon
#033 = mummy_Jesus
#034 = hentai_mower
#035 = mole_Krtecek
#036 = MASH
#037 = mug
#038 = movie
#039 = map
#040 = Rose_Tyler
#041 = rat
#042 = Ron
#043 = rum
#044 = Rory_Williams
#045 = railway
#046 = roach
#047 = rag
#048 = roof
#049 = rape
#050 = los/lace
#051 = light
#052 = Lana_Rhoades
#053 = llama
#054 = Lara
#055 = Lily
#056 = leech
#057 = leg
#058 = lava
#059 = lip/leap
#060 = cheese/chess
#061 = shit
#062 = Sheen
#063 = gem
#064 = Jar-Jar
#065 = cello
#066 = Satan
#067 = Jack_Sparrow
#068 = Jagr
#069 = sheep
#070 = goose
#071 = cat
#072 = coin/gun
#073 = cum
#074 = car
#075 = coal
#076 = cash/cage
#077 = KKK
#078 = cave
#079 = cape
#080 = vase
#081 = vat_of_acid/foot
#082 = phone/fan
#083 = family
#084 = Four/fairy
#085 = Eiffel
#086 = Fudge
#087 = faggot
#088 = Hitler
#089 = fap/vape
#090 = boss
#091 = batman
#092 = Mr.Bean
#093 = puma
#094 = bear/beer
#095 = bell
#096 = Bash/<->
#097 = book
#098 = beef
#099 = pope

string="start"

while [ "$string" != "stop" ]
do

rand=$(($RANDOM %100))

echo $rand

read string

echo $(grep "0"$rand" =" ./major.sh | awk {'print $3'})

done

else
echo Nespravne heslo
exit 

fi

