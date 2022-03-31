require 'lib.moonloader'


equire "lib.moonloader" -- подключение библиотеки
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local tag = "{0000ff}[Sobes Helper by SArMAT]: {ffffff}"
update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/CerberUSGR0/SKRIPT/main/update.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/update.ini" -- и тут свою ссылку

local script_url = "https://github.com/thechampguess/scripts/blob/master/autoupdate_lesson_16.luac?raw=true" -- тут свою ссылку
local script_path = thisScript().path

local pm = {
    ['sle'] = '”важаемый игрок! Ќачинаю работать по ¬ашей жалобе.',
    ['sln'] = '”важаемый игрок! »грок, на которого вы жаловались Ч наказан.',
    ['slo'] = '”важаемый игрок! »грок, на которого вы жаловались Ч не нарушает.',
    ['hel'] = '”важаемый игрок! —ейчас попробую ¬ам помочь.',
    ['jb'] = '”важаемый игрок, пишите жалобу на форум Ч gta-luxwen.ru.',
    ['offt'] = '”важаемый игрок, пожалуйста, не оффтопьте.',
    ['fs'] = 'Ќаш форум Ч gta-luxwen.ru, сайт Ч gta-lux.ru, группа ¬ онтакте: vk.com/luxwen_rp.',
    ['vks'] = '¬ онтакте основател€ Ч vk.com/cavallaro13, √лавного администратора Ч vk.com/obikenobii.',
    ['don'] = '„тобы приобрести привилегию, введите /donaterub (за рубли), /donate (за игровой донат).',
    ['badm'] = '„тобы стать администратором, введите /buyadm или отстойте срок лидера.',
    ['blead'] = '„тобы стать лидером, подайте за€вление на форум (gta-luxwen.ru).',
    ['bhelp'] = '„тобы стать агентом поддержки, введите /buyhelp, или же подайте за€вление на форум.',
    ['bfull'] = '„тобы приобрести полный доступ (FD), введите /buyfull.',
    ['prom'] = '„тобы получать промокоды, подпишитесь на рассылку в группе ¬  Ч vk.com/luxwen_rp.',
    ['wi'] = '”важаемый игрок, ожидайте.',
    ['otk'] = '”важаемый игрок, отказано.',
    ['kupi'] = '„тобы пополнить игровой счЄт, перейдите на наш сайт Ч gta-lux.ru.',
    ['cmd'] = 'ѕросмотреть команды сервера можно в Ђ /mm Ч 2.  оманды сервера ї.',
    ['lux'] = 'Luxwen-билеты это билеты,за которые ¬ы можете открыть контейнер (/gps Ч 13. онтейнеры).',
    ['tex'] = 'ќбратитесь в технический раздел на форуме Ч gta-luxwen.ru',
    ['fst'] = '—тили бо€: Ѕокс Ч /box,  унг-фу Ч /kongfu,  икбокс Ч /kickbox',
    ['giv'] = '/invite - прин€ть, /uninvite - уволить, /giverank - повысить/понизить ранг.',
    ['ds'] = 'Ќаш Discord сервер Ч discord.gg/yrzYjNTyGC.',
    ['lea'] = '”важаемый игрок, введите Ђ /leave ї, чтобы покинуть организацию.',
    ['accs'] = ' упите аксессуары в донате, выбейте с контейнера, или в магазине аксессуаров.',
    ['res'] = '”важаемый игрок, введите Ђ /reset ї, чтобы сн€ть все аксессуары.',
    ['rubl'] = '„тобы получить рубли, участвуйте в меропри€ти€х, получайте промокоды с рассылки.',
    ['aut'] = '”важаемый игрок, чтобы найти автосалон, введите: /gps - 2. јвтосалоны.',
    ['pasl'] = 'ѕаспорт: /pass, лицензии: /lic, мед. карту: /showmedcard, тех. паспорт т/с: /carpass.',
    ['dnk'] = ' упить дом на колЄсах: Ђ /gps - 18. ћагазин трейлеров (ƒом на колЄсах) ї.',
    ['sdnk'] = '„тобы продать ƒом на  олЄсах, введите Ђ /sellkhouse ї.',
    ['he'] = '”важаемый игрок, использовать аптечку Ч через инвентарь',
    ['add'] = '”важаемый игрок, введите: Ђ /ad Ч обычное объ€вление, /vad Ч VIP объ€вление ї.',
    ['dm'] = '”важаемый игрок, чтобы попасть в Ђ DM-зону ї , подойдите к боту ћайклу возле спавна.',
    ['dmm'] = '”важаемый игрок, чтобы покинуть Ђ DM-зону ї Ч /exitdm.',
    ['natd'] = 'NATD Ч это Ќациональный антитеррористический департамент.',
    ['natdf'] = 'NATD занимаетс€ поиском особо-опасных преступников в штате.',
    ['gss'] = '√лавный след€щий за гетто Ч Pablo Parlament (vk.com/tom_torres).',
    ['gsm'] = '√лавный след€щий за мафи€ми Ч Gorge Winston (https://vk.com/radmirtop01).',
    ['gsg'] = '√лавный след€щий за гос. структурами Ч Leon Scaletta (vk.com/me.litovsky).',
    ['kurn'] = ' уратор нелегалов Ч Blayze Noufam (vk.com/ugenrl).',
    ['kurg'] = ' уратор гос. структур Ч не назначен.',
    ['alg'] = '„тобы выйти с дома/зайти в гараж, используйте ALT.',
    ['gug'] = '„тобы вз€ть оружие, используйте Ђ /get guns ї на районе банды.',
    ['gum'] = '„тобы вз€ть оружие, используйте Ђ /getweapon ї у барной стойки возле спавна.',
    ['cpt'] = '„тобы начать войну за территорию, введите Ч Ђ /capture ї.',
    ['vip'] = '¬ведите /viphelp, чтобы посмотреть команды Ђ VIP-игрока ї.',
    ['lsgu'] = '¬ыйдите в гараж, поверните направо, и там дальше будет склад с оружием.',
    ['hcmd'] = '¬ведите /hhelp, чтобы узнать команды игрового помощника.',
    ['ut'] = '”важаемый игрок, уточните ¬аше обращение.',
    ['sus'] = ' оманда выдачи розыска Ч /su (работает с 8 ранга в PD Х с 1 ранга в FBI).',
    ['geta'] = '”важаемый игрок, чтобы получить админ-права, введите /getadm.',
    ['luxc'] = '–абота водителем металла Ч работа, в которой вы должны развозить металл с шахты.',
    ['luxcc'] = '”строитьс€ можно на шахте г. Ћас-¬ентурас, за это вы получаете Luxwen-Coins.',
    ['coin'] = '–аботайте водителем металла, чтобы получить Luxwen-Coins. ¬ведите: /coins.',
    ['vipc'] = 'ViP авто можно получить: с /donaterub, с контейнеров, меропри€тий от адм-ции.',
    ['da'] = '”важаемый игрок, да.',
    ['net'] = '”важаемый игрок, нет.',
    ['per'] = '”важаемый игрок, ¬аше обращение передано администратору!',
    ['xdon'] = '”важаемый игрок, пополнение Ђ X2 ƒонат ї работает всегда!',
    ['cha'] = '”важаемый игрок, чтобы ответить в цифровой чат, нажмите F6 .',
    ['fam'] = '”важаемый игрок, создать семью Ч Ђ /donaterub - —оздать семью ї.',
    ['hit'] = '”важаемый игрок, нажмите у красного потолка клавишу Ђ F ї.',
    ['dvig'] = '”важаемый игрок, чтобы завести двигатель, нажмите Ђ 2 ї либо командой: Ђ /en ї.',
    ['vcar'] = '”важаемый игрок, введите /cars, чтобы заспавнить свою машину.',
    ['meta'] = '”важаемый игрок, используйте /gps - 16, чтобы устроитьс€ на работу.',
    ['tiee'] = '”важаемый игрок, введите /tie, чтобы св€зать игрока.',
    ['selv'] = '”важаемый игрок, /sellvipauto id [1-билеты] [2-вирты] [3-рубли] [4-coins] сумма.',
    ['inve'] = '”важаемый игрок, нажмите Ђ Y ї или введите /inv, чтобы открыть инвентарь.',
    ['fixc'] = '”важаемый игрок, введите /fixcar - обычный т/с, /cars - ViP автомобиль т/с.',
    ['inf'] = '”важаемый игрок, не владеем данной информацией. ѕри€тной игры.',
    ['nikak'] = '”важаемый игрок, никак. ѕри€тной игры.',
    ['ras'] = '”важаемый игрок, подпишитесь на рассылку в оф. группе ¬ онтакте (vk.com/luxwen_rp).',
    ['bi'] = '”важаемый игрок, введите /buybiz, чтобы купить бизнес.',
    ['hom'] = '”важаемый игрок, вcтаньте на маркер зелЄного дома, а потом нажмите Ђ  упить ї.',
    ['chan'] = '”важаемый игрок, чтобы сменить скин во фракции, введите /changeskin (заместитель/лидер).',
    ['repp'] = '”важаемый игрок, пишите своЄ обращение в репорт. ѕри€тной игры.',
    ['spies'] = '”важаемый игрок, чтобы надеть маскировку, введите Ђ /spy ї.',
    ['rp'] = '”важаемый игрок, добирайтесь сами. ѕри€тной игры.',
    ['nos'] = '”важаемый игрок, с телефона нельз€ купить скин. “олько с ѕ . ѕри€тной игры.',
    ['qq'] = 'ѕриветствуем ¬ас, уважаемый игрок.',
    ['gg'] = 'јдминистраци€ Luxwen Role Play желает ¬ам при€тной игры, спасибо, что вы с нами :).',
    ['par'] = '”важаемый игрок, припарковать: /park - обычный транспорт, /vpark - ViP транспорт.',
    ['mas'] = '”важаемый игрок, чтобы сн€ть/надеть маску, воспользуйтесь инвентарЄм (нажмите Y).',
    ['sbiz'] = '”важаемый игрок, чтобы продать бизнес, введите /sellbiz.',
    ['shom'] = '”важаемый игрок, чтобы продать дом, введите /sellhouse.',
    ['gp'] = '”важаемый игрок, воспользуйтесь GPS-навигатором: /gps.',
    ['bb'] = 'Ќе согласны с наказанием? ѕишите жалобу на форум Ч gta-luxwen.ru.',
    ['acmd'] = 'јдминистратор, введите /ahelp, чтобы посмотреть команды администратора!',
    ['adm'] = '”важаемый игрок, дл€ просмотра администрациии, введите: /admins (с Silver ViP).',
    ['lead'] = '”важаемый игрок, дл€ просмотра лидеров, введите: /leaders.',
    ['hea'] = '”важаемый игрок, дл€ просмотра хэлперов, введите: /helpers.',
    ['rr'] = '”важаемый игрок, перезайдите на сервер.',
    ['dan'] = '”важаемый игрок, ответ дан выше. ѕри€тной игры.',
    ['an'] = '”важаемый хэлпер, чтобы ответить на обращение, введите Ђ /ans ї.',
    ['vr'] = '”важаемый игрок, чтобы общатьс€ в Ђ ViP ї чате, введите /vc.',
    ['aa'] = '”важаемый администратор, пишите в /a.',
    ['stp'] = '”важаемый игрок, чтобы изменить Ђ место спавна ї, введите /setspawn.',
    ['hc'] = '”важаемый хэлпер, чтобы общатьс€ в чате хэлперов, введите /c.',
    ['ps'] = '”важаемый игрок, не спавним. ѕри€тной игры.',
    ['lok'] = '”важаемый игрок, используйте Ђ /lock ї. ѕри€тной игры.',
    ['sbo'] = '”важаемый игрок, на сервере решаютс€ перебои. ќжидайте. ѕри€тной игры.',
    ['ing'] = '”важаемый игрок, не принимаем и не повышаем во фракции. ќбращайтесь к заму/лидеру.',
    ['chk'] = '”важаемый игрок, чтобы просмотреть список свободных постов лидера, введите /buylead.',
    ['dru'] = '”важаемый игрок, чтобы использовать наркотики, введите /usedrugs.',
    ['hou'] = '”важаемый игрок, чтобы найти свой дом, используйте /home.',
    ['invi'] = '„тобы вступить во фракцию, пройдите собеседование / вступите через auto-invite на спавне.',
    ['pri'] = '”важаемый игрок, чтобы забрать приз с контейнера, введите /priz.',
    ['sobes'] = '”важаемый игрок, уточните у лидера/зама врем€ проведени€ собеседовани€.',
    ['iiban'] = '“Ємна€ сторона на вашей стороне, но вы не сможете здесь играть.',
}
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(8000) end
    sampAddChatMessage("*({FF0000}«ам. основател€{FFFFFF}) Kenobi[66]: јдмин-помощник успешно запущен, администратор!", 0xFFFFFF)
    sampAddChatMessage("*({FF0000}«ам. основател€{FFFFFF}) Kenobi[66]: 04.03.2022 поддержка Ђ {c0c0c0}јдмин-помощника {fFFFFF}ї прекращаетс€.", 0xFFFFFF)
    sampAddChatMessage("*({FF0000}«ам. основател€{FFFFFF}) Kenobi[66]: јвтор: Kenobi | Vladik_Wakefield.", 0xFFFFFF)
    while not isSampAvailable() do wait(8000) end

    sampRegisterChatCommand("update", cmd_update)


    	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        nick = sampGetPlayerNickname(id)

        downloadUrlToFile(update_url, update_path, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                updateIni = inicfg.load(nil, update_path)
                if tonumber(updateIni.info.vers) > script_vers then
                    sampAddChatMessage("≈сть обновление! ¬ерси€: " .. updateIni.info.vers_text, -1)
                    update_state = true
                end
                os.remove(update_path)
            end
        end)

    	while true do
            wait(0)

            if update_state then
                downloadUrlToFile(script_url, script_path, function(id, status)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage("—крипт успешно обновлен!", -1)
                        thisScript():reload()
                    end
                end)
                break
            end

    	end
    end

    sampRegisterChatCommand("apm", function()
        sampShowDialog(1, "{228b22} оманды, доступные вам:", [[
{FFFFFF}1) {3CB371}/sle Ч {ffffff}ќтветить игроку, что вы {FC4347}следите {FFFFFF}за {FFD700}игроком.
{FFFFFF}2) {3CB371}/sln Ч {ffffff}ќтветить игроку, что {FC4347}нарушитель {FFFFFF}был {FFD700}наказан.
{FFFFFF}3) {3CB371}/slo Ч {ffffff}ќтветить игроку, что {FC4347}нарушений {FFD700}не обнаружено.
{FFFFFF}4) {3CB371}/hel Ч {ffffff}ѕопробовать {98FB98}помочь {FFFFFF}игроку.
{FFFFFF}5) {3CB371}/jb Ч {ffffff}ќтветить игроку, чтобы написал {FC4347}жалобу на форум.
{FFFFFF}6) {3CB371}/offt Ч {ffffff}ќтветить игроку, чтобы {FC4347}не оффтопил.
{FFFFFF}7) {3CB371}/otk Ч {FF0000}ќтказать {FFFFFF}игроку.
{FFFFFF}8) {008080}/da Ч {FFFFFF}ќтветить игроку Ђ {00FF00}да {FFFFFF}ї.
{FFFFFF}9) {008080}/net Ч {FFFFFF}ќтветить игроку Ђ {b22222}нет {FFFFFF}ї.
{FFFFFF}10) {FFDAB9}/nikak Ч {FFFFFF}ќтветить игроку, Ђ никак ї.
{FFFFFF}11) {32cd32}/qq Ч {FFFFFF}ѕоприветствовать игрока.
{FFFFFF}12) {F0E68C}/hom Ч {FFFFFF}ќтветь игроку, как купить дом.
{FFFFFF}13) {F0E68C}/biz Ч {FFFFFF}ќтветить игроку, как купить бизнес.
{FFFFFF}14) {CD853F}/repp Ч {FFFFFF}ќтветить игроку, чтобы писал в репорт.
{FFFFFF}15) {3CB371}/ut Ч {FFFFFF}ќтветить игроку, чтобы {FFFF00}уточнил {FFFFFF}своЄ {00BFFF}обращение.
{FFFFFF}16) {3CB371}/wi Ч {ffffff}ќтветить игроку, чтобы {FFFF00}ожидал.
{FFFFFF}17) {FFD700}/gsm Ч {FFFFFF}ќтветить игроку, кто {A0522D}√лавный —лед€щий за мафи€ми.
{FFFFFF}18) {FFD700}/gsg Ч {FFFFFF}ќтветить игроку, кто {4169E1}√лавный —лед€щий за гос. структурами.
{FFFFFF}19) {FFD700}/gss Ч {FFFFFF}ќтветить игроку, кто {228B22}√лавный —лед€щий за гетто.
{FFFFFF}20) {FFD700}/kurn Ч {FFFFFF}ќтветить игроку, кто {8B0000} уратор Ќелегалов.
{FFFFFF}21) {FFD700}/kurg Ч {FFFFFF}ќтветить игроку, кто {4169E1} уратор √ос. структур.
{FFFFFF}22) {FFD700}/vks Ч {FFFFFF}ќтветить игроку, кто {2681ff}√лавный јдминистратор {FFFFFF}и {FF0000}основатель сервера.
{FFFFFF}23) {ADFF2F}/buyfull Ч {FFFFFF}ќтветить игроку, как получить {FF6347}Full Dostup.
{FFFFFF}24) {ADFF2F}/badm Ч {ffffff}ќтветить игроку, как получить {FFD700}пост администратора.
{FFFFFF}25) {ADFF2F}/blead Ч {ffffff}ќтветить игроку, как получить {FFD700}пост лидера.
{FFFFFF}26) {ADFF2F}/bhelp Ч {ffffff}ќтветить игроку, как получить {FFD700}пост агента поддержки.
{FFFFFF}27) {ADFF2F}/promo Ч {ffffff}–ассылка на {FFD700}промокоды.
{FFFFFF}28) {ADFF2F}/kupi Ч {FFFFFF}ќтветить игроку, где {FFD700}пополнить счЄт.
{FFFFFF}29) {ADFF2F}/don Ч {FFFFFF}ќтветить игроку, как открыть {FFD700}донат.
{FFFFFF}30) {DAA520}/tex Ч {FFFFFF}ѕризвать игрока обратитьс€ в {F4A460}технический раздел {FFFFFF}на форуме.
{FFFFFF}31) {DAA520}/ds Ч {FFFFFF}—кинуть ссылку на {6495ED}Discord сервер.
{FFFFFF}32) {DAA520}/dnk Ч {ffffff}ќтветить игроку, где купить {9ACD32}ƒом на колЄсах {FFFFFF}({9ACD32}ƒЌ {FFFFFF}).
{FFFFFF}33) {DAA520}/sdnk Ч {FFFFFF}ќтветить игроку, как убрать {9ACD32}ƒом на колЄсах {FFFFFF}({9ACD32}ƒЌ {FFFFFF}).
{FFFFFF}34) {9370DB}/cmd Ч {FFFFFF}ќтветить про {9370DB}команды сервера.
{FFFFFF}35) {9370DB}/fst Ч {FFFFFF}ќтветить игроку про {9370DB}стили бо€.
{FFFFFF}36) {9370DB}/giv Ч {FFFFFF}ќтветить игроку про возможности {FF6347}лидера {FFFFFF}и {FF6347}заместител€.
{FFFFFF}37) {9370DB}/lea Ч {FFFFFF}ќтветить игроку, как {9370DB}уволитьс€.
{FFFFFF}38) {9370DB}/accs Ч {FFFFFF}ќтветить игроку, как {32cd32}надеть {9370DB}аксессуары.
{FFFFFF}39) {9370DB}/res Ч {FFFFFF}ќтветить игроку, как {FF4500}сн€ть все {9370DB}аксессуары.
{FFFFFF}40) {D8BFD8}/rubl Ч {FFFFFF}ќтветить игроку, как получить {D8BFD8}рубли.
{FFFFFF}41) {9370DB}/aut Ч {FFFFFF}ќтветить игроку, где находитс€ {DB7093}јвтосалон.
{FFFFFF}42) {9370DB}/pasl Ч {FFFFFF}ќтветить игроку, как показать {32cd32}все {FFFFFF}свои {D2691E}документы.
{FFFFFF}43) {FFFF00}/lux Ч {FFFFFF}ќтветить игроку, что такое {FFFF00}Luxwen билеты.
{FFFFFF}44) {008000}/he Ч {FFFFFF}ќтветить игроку, как использовать {4682B4}аптечку.
{FFFFFF}45) {008000}/adv Ч {FFFFFF}ќтветить игроку, как отправить {00FF00}объ€вление.
{FFFFFF}46) {FF6347}/dm Ч {FFFFFF}ќтветить игроку, как {008000}войти {FFFFFF} в {FF7F50}DM-зону.
{FFFFFF}47) {FF6347}/dmm Ч {FFFFFF}ќтветить игроку, как {FF4500}выйти {FFFFFF}с {FF7F50}DM-зоны.
{FFFFFF}48) {FF8C00}/alg Ч {FFFFFF}ќтветить игроку, как выйти с дома/зайти в гараж.
{FFFFFF}49) {FF8C00}/gug Ч {FFFFFF}ќтветить игроку, как вз€ть оружие в {9ACD32}банде.
{FFFFFF}50) {FF8C00}/gum Ч {FFFFFF}ќтветить игроку, как вз€ть оружие в {8B0000}мафии.
{FFFFFF}51) {FF8C00}/lsgu Ч {FFFFFF}ќтветить игроку, как вз€ть оружие в {4169E1}LSPD.
{FFFFFF}52) {DB7093}/vip Ч {FFFFFF}ќтветить игроку, какие команды есть у {FFD700}VIP.
{FFFFFF}53) {DB7093}/cpt Ч {FFFFFF}ќтветить игроку, как начать {FF6347}войну за территорию.
{FFFFFF}54) {DB7093}/tiee Ч {FFFFFF}ќтветить игроку, как {20B2AA}св€зать {FFFFFF}игрока.
{FFFFFF}55) {E9967A}/hcmd Ч {FFFFFF}ќтветить игроку, как {32cd32}посмотреть команды {FFFF00}хелпера.
{FFFFFF}56) {A52A2A}/sus - {FFFFFF}ќтветить игроку, как выдать {4169E1}розыск {FFFFFF}игроку.
{FFFFFF}57) {FFFF00}/luxc Ч {FFFFFF}ќтветить игроку, что представл€ет из себ€ работа {66CDAA}–азвозчика металла.
{FFFFFF}58) {FFFF00}/luxcc Ч {FFFFFF}ќтветить игроку, что представл€ет из себ€ работа {66CDAA}–азвозчик металла.
{FFFFFF}59) {A9A9A9}/meta Ч {FFFFFF}ќтветить игроку, где устроитьс€ {FFFFFF}на работу {66CDAA}¬одител€ металла.
{FFFFFF}60) {FFFF00}/coin Ч {FFFFFF}ќтветить игроку, что такое {FFA500}Luxwen-Coins.
{FFFFFF}61) {DC143C}/vipc Ч {FFFFFF}ќтветить игроку, где вз€ть {FF00FF}ViP транспорт.
{FFFFFF}62) {A9A9A9}/sellv Ч {FFFFFF}ќтветить игроку, как продать {FF00FF}ViP транспорт.
{FFFFFF}63) {a9a9a9}/fixc Ч {FFFFFF}ќтветить игроку, как заспавнить машину.
{FFFFFF}64) {Dc143C}/per Ч {FFFFFF}ѕередать {FFD700}обращение {FFFFFF}другому администратору.
{FFFFFF}65) {6A5ACD}/cha Ч {FFFFFF}ќтветить игроку, как ответить в {AFEEEE}цифровой чат.
{FFFFFF}66) {FFD700}/xdon Ч {FFFFFF}ќтветить игроку, что {FF4500}X2 ƒонат. {FFFFFF}работает всегда.
{FFFFFF}67) {3CB371}/fam Ч {FFFFFF}ќтветить игроку, как {32cd32}создать семью.
{FFFFFF}68) {00FF7F}/dvig Ч {FFFFFF}ќтветить игроку, как {7FFFD4}завести двигатель.
{FFFFFF}69) {A9A9A9}/hit Ч {FFFFFF}ќтветить игроку, как {6495ED}открыть дверь {FFFFFF}у ’итманов.
{FFFFFF}70) {FFDAB9}/inve Ч {FFFFFF}ќтветить игроку, чтобы воспользовалс€ {FFFF00}инвентарЄм.
{FFFFFF}71) {FF0000}/inf Ч {FFFFFF}ќтветить игроку, что вы не владеете нужной игроку информацией.
{FFFFFF}72) {FFDAB9}/ras Ч {FFFFFF}ќтветить игроку, где можно прин€ть участие в раздачах.
{FFFFFF}73) {008000}/nos Ч {FFFFFF}ќтветить игроку, что с телефона нельз€ {228b22}купить {98FB98}скин.
{FFFFFF}74) {CD853F}/rp Ч {FFFFFF}ќтветить игроку, чтобы {DAA520}добиралс€ {FFFFFF}сам.
{FFFFFF}75) {FFF000}/spies Ч {FFFFFF}ќтветить игроку, как надеть маскировку в ‘Ѕ–/’итманах.
{FFFFFF}76) {FFC500}/chan Ч {FFFFFF}ќтветить игроку, как помен€ть {9370DB}скин во {FFA07A}фракции.
{FFFFFF}77) {c0c0c0}/gar Ч {FFFFFF}ќтветить игроку, что его {DDA0DD}машина находитс€ в {FFF000}гараже дома.
{FFFFFF}78) {A0522D}/gg Ч {FFFFFF}ѕожелать игроку {6495ED}при€тной {FFFFFF}игры.
{FFFFFF}79) {DC143C}/shom Ч {FFFFFF}ќтветить игроку, как продать дом.
{FFFFFF}80) {DC143C}/sbiz Ч {FFFFFF}ќтветить игроку, как продать бизнес.
{FFFFFF}81) {DC143C}/par Ч {FFFFFF}ќтветить игроку, как {CD5C5C}припарковать свой транспорт.
{FFFFFF}82) {DC143C}/mas Ч {FFFFFF}ќтветить игроку, как {FF0000}сн€ть/{228B22}надеть маску.
{FFFFFF}83) {DC143C}/gp Ч {FFFFFF}ќтветить игроку, чтобы воспользовалс€ навигатором (GPS).
{FFFFFF} 84) {00FF00}/lead Ч {FFFFFF}ќтветить игроку, как открыть список {228b22}лидеров.
{FFFFFF} 85) {00FF00}/adm Ч {FFFFFF}ќтветить игроку, как открыть список {FF0000}администрации.
{FFFFFF} 86) {00FF00}/hea Ч {FFFFFF}ќтветить игроку, как открыть список {ffd700}хэлперов.
{FFFFFF} 87) {6B8E23}/acmd Ч {FFFFFF}ќтветить администратору, как открыть {98FB98}команды администратора.
{FFFFFF} 88) {87CEFA}/aa Ч {FFFFFF}ќтветить администратору, чтобы писал в {7CFC00}админ. {FFFFFF}чат.
{FFFFFF} 89) {CD853F}/rr Ч {FFFFFF}ќтветить игроку, чтобы {F0E68C}перезашЄл {FFFFFF}на сервер.
{FFFFFF} 90) {BC8F8F}/dan Ч {FFFFFF}ќтветить игроку, что на его {1E90FF}обращение {FFFFFF}уже {FFFF00}дан ответ.{FFFFFF} 91) {DEB887}/an Ч {FFFFFF}ќтветить хэлперу, как ответить на {A0522D}репорт.{FFFFFF} 92) {7FFFD4}/hc Ч {FFFFFF}ќтветить хэлперу, как писать в чат {EE82EE}хэлперов.
{FFFFFF} 91) {8FBC8F}/stp Ч {FFFFFF}ќтветить игроку, как поставить {FF8C00}место спавна.
{FFFFFF} 93) {FF1493}/vr Ч {FFFFFF}ќтветить игроку, как писать в {1E90FF}ViP {FFFFFF}чат.
{FFFFFF} 94) {3CB371}/ps Ч {FFFFFF}ќтветить игроку, что не {DAA520}спавним.
{FFFFFF} 95) {FF7F50}/lok Ч {FFFFFF}ќтветить игроку, как {00FF00}открыть {FFFFFF}т/с.
{FFFFFF} 96) {FF4500}/sbo Ч {FFFFFF}ќтветить игроку, что наблюдаютс€ {FF6347}перебои {FFFFFF}на сервере.
{FFFFFF} 97) {FFA500}/ing Ч {FFFFFF}ќтветить игроку, что {FF0000}не принимаем{FFFFFF}/{FF0000}не повышаем.
{FFFFFF} 98) {FFA500}/chk Ч {FFFFFF}ќтветить игроку, как посмотреть список свободных лидерств.
{FFFFFF} 99) {FFA500}/dru Ч {FFFFFF}ќтветить игроку, как использовать наркотики.
{FFFFFF} 100) {FFA500}/hou Ч {FFFFFF}ќтветить игроку, как найти свой дом.
{FFFFFF} 101) {FFA500}/sobes Ч {FFFFFF}ќтветить игроку, чтобы уточн€л дату проведени€ собеса у лидера/зама.
{FFFFFF} 102) {FFA500}/pri Ч {FFFFFF}ќтветить игроку, как забрать приз с контейнеров.
{FFFFFF} 103) {FFA500}/invi Ч {FFFFFF}ќтветить игроку, как вступить во фракцию]], "{FFFFFF}ѕрин€ть", "", 4)
    end)
sampRegisterChatCommand("anak", function()
        sampShowDialog(1, "{FFF000}ѕравила выдачи наказаний", [[
{b22222}“юрьма {B22222}({FFFFFF}/jail{B22222}) {B22222}выдаЄтс€ за{FFFFFF}:
{B22222}* {FFFFFF}”бийство без причины (DM). Ќаказание: 15 минут /jail.
{B22222}* {FFFFFF}”бийство без причины в «елЄной «оне (DM ZZ). Ќаказание: 20 минут /jail.
{b22222}* {FFFFFF}”бийство членов дружеской фракции (“ ). Ќаказание: 20 минут /jail.
{B22222}* {FFFFFF}”бийство с машины (DB). Ќаказание: 15 минут /jail.
{B22222}* {FFFFFF}”бийство при спавне (SK). Ќаказание: 20 минут /jail.
{B22222}* {FFFFFF} оп в гетто. Ќаказание: 10 минут /jail
{B22222}* {FFFFFF}“аран/убийство при помощи ковша. Ќаказание: 45 минут /jail.
{B22222}* {FFFFFF}—бив анимации. Ќаказание: 20 минут /jail.
{B22222}* {FFFFFF}Powergaming (воображение из себ€ геро€). Ќаказание: 15 минут /jail.
{B22222}* {FFFFFF}NonRP действи€. Ќаказание: 20 минут /jail.

{FFD700}ћут репорта ({FFFFFF}/rmute{FFd800}) выдаЄтс€ за:
{FFD700}* {FFFFFF}∆алоба/вопрос, не касающа€с€ сервера Luxwen RP. Ќаказание: 15 минут /rmute.
{FFD700}* {FFFFFF}Ќеадекватное поведение. Ќаказание: 60 минут /rmute.
{FFD700}* {FFFFFF}Caps-Lock. Ќаказание: 15 минут /rmute.
{FFD700}* {FFFFFF}ƒублирование жалоб/вопросов, на которых был дан ответ. Ќаказание: 10 минут /rmute.

{FFA500}ћут ({FFFFFF}/mute{FFA500}) выдаЄтс€ за:
{FFA500}* {FFFFFF}»спользование информации из реального мира в игровой чат (MG). Ќаказание: 5 минут /mute.
{FFA500}* {FFFFFF}ќскорбление игрока. Ќаказание: 25 минут /mute.
{FFA500}* {FFFFFF}ќскорбление администрации. Ќаказание: 180 минут /mute.
{FFA500}* {FFFFFF}”поминание родных игрока. Ќаказание: 180 минут /mute.
{FFA500}* {FFFFFF}Caps-Lock. Ќаказание: 10 минут /mute.
{FFA500}* {FFFFFF}Flood. Ќаказание: 15 минут /mute.
{FFA500}* {FFFFFF}–озжиг межнациональной розни. Ќаказание: 60 минут /mute.
{FFA500}* {FFFFFF}—говор игроков с целью на флуд/подачи жалобы в репорт с идентичным сообщением. Ќаказание: 180 минут /mute или 2 дн€ /ban.
{FFA500}* {FFFFFF}Ќеадекватное поведение. Ќаказание: 45 минут /mute или 7 дней /ban.

{FC4347}ѕредупреждение ({FFFFFF}/warn{FC4347}) {FC4347}выдаЄтс€ за:
{FC4347}* {FFFFFF}ћассовое ƒћ/— /ƒЅ/“ .
{FC4347}* {FFFFFF}NonRP коп.
{FC4347}* {FFFFFF}¬ыход во врем€ ареста.
{FC4347}* {FFFFFF}¬ыход во врем€ согласованного администрацией похищени€.

{FF0000}Ѕлокировка аккаунта ({FFFFFF}/ban{FF0000}) выдаЄтс€ за:
{FF0000}* {FFFFFF}»спользование любых видов читов. Ќаказание: 21 день /ban.
{FF0000}* {FFFFFF}ќскорбление родных администратора/игрока. Ќаказание: 21 дней /ban.
{FF0000}* {FFFFFF}ќскорбление проекта. Ќаказание: 30 дней /ban.
{FF0000}* {FFFFFF}»спользование багов игры/сервера в корыстных цел€х. Ќаказание: 7 дней /ban.
{FF0000}* {FFFFFF}–еклама сторонних ресурсов. Ќаказание: 30 дней /ban, /banip.
{FF0000}* {FFFFFF}ќбман администрации. Ќаказание: 14-66 дней бана.
{FF0000}* {FFFFFF}ƒенежные махинации (продажа восстановлений на адм., нелегальна€ продажа админок и т.п.). Ќаказание: „Єрный список проекта навсегда.
{FF0000}* {FFFFFF}—говор игроков с целью на флуд/подачи жалобы в репорт с идентичным сообщением. Ќаказание: 2 дн€ /ban.

                                             {FF0000}ќбратите ¬нимание! {FFFFFF}ƒл€ руковод€щего состава действуют исключени€.
                                             {FF0000}ќбратите ¬нимание! {FFFFFF}Ќезнание не освобождает от ответственности!
                                               некоторым случа€м к /ban возможны наказани€ по {FF0000}IP адресу.
]], "{FFFFFF}ѕрин€ть", "", 0)
    end)
sampRegisterChatCommand("hrep", function()
        sampShowDialog(1, "{FFF000}—истема повышени€", [[
{FFFFFF}Ќа {228b22}2 {FFFFFF}уровень администрировани€ Ч {FFD700}100 репортов.
{FFFFFF}Ќа {228b22}3 {FFFFFF}уровень администрировани€ Ч {FFD700}200 репортов.
{FFFFFF}Ќа {228b22}4 {FFFFFF}уровень администрировани€ Ч {FFD700}300 репортов.
{FFFFFF}Ќа {228b22}5 {FFFFFF}уровень администрировани€ Ч {FFD700}400 репортов.
{FFFFFF}Ќа {228b22}6 {FFFFFF}уровень администрировани€ Ч {FFD700}500 репортов.
{FFFFFF}Ќа {228b22}7 {FFFFFF}уровень администрировани€ Ч {FFD700}600 репортов.
{FFFFFF}Ќа {228b22}8 {FFFFFF}уровень администрировани€ Ч {FFD700}700 репортов.
{FFFFFF}Ќа {228b22}9 {FFFFFF}уровень администрировани€ Ч {FFD700}750 репортов.
{FFFFFF}Ќа {228b22}10 {FFFFFF}уровень администрировани€ Ч {FFD700}800 репортов.
{FFFFFF}Ќа {228b22}11 {FFFFFF}уровень администрировани€ Ч {FFD700}1050 репортов.
{FFFFFF}Ќа {228b22}12 {FFFFFF}уровень администрировани€ Ч {FFD700}1200 репортов.

{FFFFFF}—н€ть {FF6347}выговор {FFFFFF}за {228b22}репорты:
{FF6347}1 {FFFFFF}выговор Ч {FF6347}350 репортов.
{FF6347}2 {FFFFFF}выговора Ч {FF6347}700 репортов.
{FFFFFF}ќтчЄты на повышение уровн€ писать в Discord сервер, в раздел {4169E1}#отчЄты.
{FFFFFF}ѕо поводу сн€тие {ff6347}выговора{FFFFFF}, обратитесь к {9400D3}«аместителю √ј {FFFFFF}или к {2681ff}√лавному јдминистратору.]], "{FFFFFF}ѕрин€ть", "", 0)
    end)
sampRegisterChatCommand("ahelp", function()
        sampShowDialog(1, "{FFF000}—писок команд администратора", [[
{7FFFD4}1 уровень:
{FFFFFF}/anak - {7FFFD4}посмотреть правила выдачи наказаний.
{FFFFFF}/aprav - {7FFFD4}посмотреть правила администрации.
{FFFFFF}/mystats - {7FFFD4}посмотреть статистику администратора.
{FFFFFF}/agm - {7FFFD4}включить бессмертие.
{FFFFFF}/a - {7FFFD4}чат администраторов.
{FFFFFF}/admins - {7FFFD4}список администрации online.
{FFFFFF}/pm - {7FFFD4}ответить игроку.
{FFFFFF}/tp - {7FFFD4}список телепорта.
{FFFFFF}/re - {7FFFD4}слежка за игроком.
{FFFFFF}/hp - {7FFFD4}пополнить себе здоровье (100 hp).
{FFFFFF}/gg - {7FFFD4}пожелать игроку при€тной игры.
{FFFFFF}/spawn - {7FFFD4}заспавнить игрока.
{FFFFFF}/wantedlist - {7FFFD4}список преступников.
{FFFFFF}/mutelist - {7FFFD4}список игроков с блокировкой чата.
{FFFFFF}/jaillist - {7FFFD4}список игроков, которые наход€тс€ в тюрьме.

{32CD32}2 уровень:
{FFFFFF}/slap - {32CD32}подкинуть игрока вверх.
{FFFFFF}/jail - {32CD32}посадить игрока в тюрьму.
{FFFFFF}/chat - {32CD32}включить просмотр игрового чата.
{FFFFFF}/chatsms - {32CD32}включить просмотр SMS сообщений.
{FFFFFF}/g(oto) - {32CD32}телепортироватьс€ к игроку.
{FFFFFF}/alock - {32CD32}закрыть любую машину.
{FFFFFF}/freeze - {32CD32}заморозить игрока.
{FFFFFF}/unfreeze - {32CD32}разморозить игрока.

{3CB371}3 уровень:
{FFFFFF}/skin - {3CB371}сменить себе одежду.
{FFFFFF}/mark - {3CB371}установить метку.
{FFFFFF}/gotomark - {3CB371}телепортироватьс€ по заданной метке.
{FFFFFF}/iwep - {3CB371}просмотр оружи€ у игрока.
{FFFFFF}/sethp - {3CB371}сменить уровень здоровь€ игроку.
{FFFFFF}/warehouse - {3CB371}просмотр склада организаций.

{20B2AA}4 уровень:
{FFFFFF}/jetpack - {20B2AA}использовать реактивный ранец.
{FFFFFF}/stats - {20B2AA}узнать статистику игрока (полна€ команда - /getstats).
{FFFFFF}/kickpb - {20B2AA}исключить игрока из участи€ в PaintBall.
{FFFFFF}/offmute - {20B2AA}выдать блокировку чата игроку в offline.
{FFFFFF}/offjail - {20B2AA}выдать тюрьму игроку в offline.

{66CDAA}5 уровень:
{FFFFFF}/kick - {66CDAA}кикнуть игрока.
{FFFFFF}/history - {66CDAA}просмотр всех ников игрока.
{FFFFFF}/delveh - {66CDAA}удалить созданный транспорт администратором.
{FFFFFF}/fuelcars - {66CDAA}заправить все транспортные средства.
{FFFFFF}/spawncars - {66CDAA}заспавнить весь незан€тый транспорт игроками.
{FFFFFF}/gethere - {66CDAA}телепортировать игрока к себе.

{D8BFD8}6 уровень:
{FFFFFF}/warn - {D8BFD8}выдать предупреждение игроку.
{FFFFFF}/ptp - {D8BFD8}телепортировать игрока к игроку.
{FFFFFF}/givegun - {D8BFD8}выдать оружие игроку.
{FFFFFF}/balance - {D8BFD8}посмотреть баланс организаций.
{FFFFFF}/pgetip - {D8BFD8}проверить по IP адресу наличие аккаунтов у игрока.

{DDA0DD}7 уровень:
{FFFFFF}/getoffstats - {DDA0DD}посмотреть статистику игрока offline.
{FFFFFF}/setskin - {DDA0DD}сменить одежду игроку.
{FFFFFF}/warnmans - {DDA0DD}список игроков с предупреждением (warn).
{FFFFFF}/offwarn - {DDA0DD}выдать предупреждение offline.
{FFFFFF}/ooc - {DDA0DD}общий чат.

{EE82EE}8 уровень:
{FFFFFF}/ban - {EE82EE}заблокировать аккаунт игрока.
{FFFFFF}/unban - {EE82EE}разблокировать аккаунт игрока.
{FFFFFF}/gzcolor - {EE82EE}взаимодействие с территорией.
{FFFFFF}/unwarn - {EE82EE}сн€ть предупреждение игроку.
{FFFFFF}/dvall - {EE82EE}удалить весь созданный транспорт администратором.
{FFFFFF}/getip - {EE82EE}узнать IP адрес игрока (REG IP - когда регистрировалс€, L IP - последний заход на сервер, IP - играет сейчас).
{FFFFFF}/spveh - {EE82EE}заспавнить ¬≈—№ транспорт в радиусе.
{FFFFFF}/offgoto - {EE82EE}запрет на телепорт к себе.

{FFD700}9 уровень:
{FFFFFF}/aad - {FFD700}объ€вление от администратора.
{FFFFFF}/amembers - {FFD700}просмотр членов организаций online.
{FFFFFF}/agl - {FFD700}выдать все лицензии игроку.
{FFFFFF}/templeader - {FFD700}назначить себ€ временным членом организации.
{FFFFFF}/getban - {A52A2A}узнать причину блокировки аккаунта.
{FFFFFF}/getbanip - {FFD700}узнать причину блокировки аккаунта по IP адресу.

{FFA500}10 уровень:
{FFFFFF}/offban - {FFA500}заблокировать аккаунт offline.
{FFFFFF}/ghetto - {FFA500}поставить запрет банде каптитьс€.
{FFFFFF}/mpwin - {FFA500}выдать приз (донат-очки).
{FFFFFF}/settp - {FFA500}установить точку телепорта дл€ игроков.
{FFFFFF}/givebil - {FFA500}выдать военный билет.
{FFFFFF}/givemedcard - {FFA500}выдать медицинскую карту.
{FFFFFF}/sban - {FFA500}тихо заблокировать аккаунт.
{FFFFFF}/object - {FFA500}установить объекты на скин.
{FFFFFF}/uval - {FFA500}уволить игрока.
{FFFFFF}/setbizmafia - {FFA500}выдать бизнес мафии.

{6A5ACD}11 уровень:
{FFFFFF}/offleader - {6A5ACD}сн€ть лидера offline.
{FFFFFF}/setleader - {6A5ACD}назначить игрока на пост лидера.
{FFFFFF}/fid - {6A5ACD}посмотреть id организаций.
{FFFFFF}/noooc - {6A5ACD}включить/выключить доступ к общему чату.
{FFFFFF}/mp - {6A5ACD}меню меропри€ти€.
{FFFFFF}/veh - {6A5ACD}создать машину.
{FFFFFF}/startpb - {6A5ACD}запустить PaintBall.
{FFFFFF}/startrace - {6A5ACD}запустить гонки.
{FFFFFF}/startbase - {6A5ACD}запустить бейсджампинг.
{FFFFFF}/setmats - {6A5ACD}изменить количество материалов организаци€м.

{FF6347}12 уровень:
{FFFFFF}/offhelper - {FF6347}сн€ть агента поддержки.
{FFFFFF}/agiverank - {FF6347}выдать игроку ранг.
{FFFFFF}/hstats - {FF6347}посмотреть статистику агента поддержки.
{FFFFFF}/cc - {FF6347}очистить чат.
{FFFFFF}/sethelper - {FF6347}назначить на пост агента поддержки.
{FFFFFF}/skick - {FF6347}тихий кик.
{FFFFFF}/iban - {FF6347}заблокировать аккаунт игрока навсегда.
{FFFFFF}/hcheck - {FF6347}посмотреть список помощников.
{FFFFFF}/lip - {FF6347}последний IP игрока.
{FFFFFF}/unbanip - {FF6347}разблокировать IP игрока.
{FFFFFF}/banip - {FF6347}заблокировать по IP игрока.
{FFFFFF}/tpcor - {FF6347}телепортироватьс€ по координатам по x, y, z.
{FFFFFF}/atune - {FF6347}админска€ автомастерска€.
{FFFFFF}/forceskin - {FF6347}допустить игрока к измене скина.
{FFFFFF}/election - {FF6347}сделать выбора президента в ћэрии.
{FFFFFF}/agivevip - {FF6347}выдать VIP игроку.]], "{FFFFFF}ѕрин€ть", "", 4)
    end)
sampRegisterChatCommand("idguns", function()
        sampShowDialog(1, "{FFF000}ID оружий", [[
{FFA500}1 Ч {6495ED} астет.
{FFA500}2 Ч {6495ED} люшка дл€ гольфа.
{FFA500}3 Ч {6495ED}ѕолицейска€ дубинка.
{FFA500}4 Ч {6495ED}Ќож.
{FFA500}5 Ч {6495ED}Ѕейсбольна€ бита.
{FFA500}6 Ч {6495ED}Ћопата.
{FFA500}7 Ч {6495ED}Ѕиль€рдный кий.
{FFA500}8 Ч {6495ED} атана.
{FFA500}9 Ч {6495ED}Ѕензопила.
{FFA500}10 Ч {6495ED}‘иолетовый дилдо.
{FFA500}11 Ч {6495ED}ƒилдо.
{FFA500}12 Ч {6495ED}¬ибратор.
{FFA500}13 Ч {6495ED}—еребр€нный вибратор.
{FFA500}14 Ч {6495ED}÷веты.
{FFA500}15 Ч {6495ED}“рость.
{FFA500}16 Ч {6495ED}√раната.
{FFA500}17 Ч {6495ED}—лезоточивый газ.
{FFA500}18 Ч {6495ED} октейль ћолотова.
{FFA500}22 Ч {6495ED}ѕистолет.
{FFA500}23 Ч {6495ED}ѕистолет с глушителем.
{FFA500}24 Ч {6495ED}ѕустынный орЄл (Deagle).
{FFA500}25 Ч {6495ED}ƒробовик.
{FFA500}26 Ч {6495ED}ќбрез.
{FFA500}27 Ч {6495ED}Ѕоевой дробовик.
{FFA500}28 Ч {6495ED}ћикро UZI.
{FFA500}29 Ч {6495ED}ћѕ-5.
{FFA500}30 Ч {6495ED}јвтомат  алашникова.
{FFA500}31 Ч {6495ED}јвтомат ћ4.
{FFA500}32 Ч {6495ED}“ек-9.
{FFA500}33 Ч {6495ED}¬интовка (Rifle).
{FFA500}34 Ч {6495ED}—найперска€ винтовка.
{FFA500}35 Ч {6495ED}–акетница.
{FFA500}36 Ч {6495ED}—амонавод€ща€с€ ракетница.
{FFA500}37 Ч {6495ED}ќгнемЄт.
{FFA500}38 Ч {6495ED}ћиниган.
{FFA500}39 Ч {6495ED}«ар€д ранца.
{FFA500}40 Ч {6495ED}ƒетонатор.
{FFA500}41 Ч {6495ED}Ѕалончик с краской.
{FFA500}42 Ч {6495ED}ќгнетушитель.
{FFA500}43 Ч {6495ED}‘отоаппарат.
{FFA500}44 Ч {6495ED}ќчки ночного видени€.
{FFA500}45 Ч {6495ED}ќчки теплового видени€.
{FFA500}46 Ч {6495ED}ѕарашют.]], "{FFFFFF}ѕрин€ть", "", 0)
    end)
sampRegisterChatCommand("idskins", function()
        sampShowDialog(1, "{FFF000}ID скинов", [[
{FFA500}1 Ч {6495ED}The Truth.
{FFA500}2 Ч {6495ED}Maccer.
{FFA500}3 Ч {6495ED}Andre.
{FFA500}4 Ч {6495ED}Barry "Big Bear" Thorne [Thin].
{FFA500}5 Ч {6495ED}Barry "Big Bear" Thorne [Big].
{FFA500}6 Ч {6495ED}Emmet.
{FFA500}7 Ч {6495ED}Taxi Driver/Train Driver.
{FFA500}8 Ч {6495ED}Janitor.
{FFA500}9 Ч {6495ED}Normal Ped.
{FFA500}10 Ч {6495ED}Old Woman.
{FFA500}11 Ч {6495ED}Casino croupier.
{FFA500}12 Ч {6495ED}Rich woman
{FFA500}13 Ч {6495ED}Street Girl.
{FFA500}14 Ч {6495ED}Normal Ped.
{FFA500}15 Ч {6495ED}Mr.Whittaker (RS Haul Owner).
{FFA500}16 Ч {6495ED}Airport Ground Worker.
{FFA500}17 Ч {6495ED}Businessman.
{FFA500}18 Ч {6495ED}Beach Visitor.
{FFA500}19 Ч {6495ED}DJ.
{FFA500}20 Ч {6495ED}Rich Guy.
{FFA500}21 Ч {6495ED}Normal Ped.
{FFA500}22 Ч {6495ED}Normal Ped.
{FFA500}23 Ч {6495ED}BMXer.
{FFA500}24 Ч {6495ED}Madd Dogg Bodyguard.
{FFA500}25 Ч {6495ED}Madd Dogg Bodyguard.
{FFA500}26 Ч {6495ED}Backpacker.
{FFA500}27 Ч {6495ED}Construction Worker.
{FFA500}28 Ч {6495ED}Drug Dealer.
{FFA500}29 Ч {6495ED}Drug Dealer.
{FFA500}30 Ч {6495ED}Drug Dealer.
{FFA500}31 Ч {6495ED}Farm-Town inhabitant.
{FFA500}32 Ч {6495ED}Farm-Town inhabitant.
{FFA500}33 Ч {6495ED}Farm-Town inhabitant.
{FFA500}34 Ч {6495ED}Farm-Town inhabitant.
{FFA500}35 Ч {6495ED}Gardener.
{FFA500}36 Ч {6495ED}Golfer.
{FFA500}37 Ч {6495ED}Golfer.
{FFA500}38 Ч {6495ED}Normal Ped.
{FFA500}39 Ч {6495ED}Normal Ped (Old Woman).
{FFA500}40 Ч {6495ED}Normal Ped.
{FFA500}41 Ч {6495ED}Normal Ped.
{FFA500}42 Ч {6495ED}Jethro.
{FFA500}43 Ч {6495ED}Normal Ped.
{FFA500}44 Ч {6495ED}Normal Ped.
{FFA500}45 Ч {6495ED}Beach Visitor.
{FFA500}46 Ч {6495ED}Normal Ped
{FFA500}47 Ч {6495ED}Normal Ped.
{FFA500}48 Ч {6495ED}Normal Ped.
{FFA500}49 Ч {6495ED}Snakehead (Da Nang).
{FFA500}50 Ч {6495ED}Mechanic.
{FFA500}51 Ч {6495ED}Mountain Biker.
{FFA500}52 Ч {6495ED}Mountain Biker.
{FFA500}53 Ч {6495ED}Normal Ped (Old Woman).
{FFA500}54 Ч {6495ED}Normal Ped (Old Woman).
{FFA500}55 Ч {6495ED}Normal Ped.
{FFA500}56 Ч {6495ED}Normal Ped.
{FFA500}57 Ч {6495ED}Oriental Ped.
{FFA500}58 Ч {6495ED}Oriental Ped.
{FFA500}59 Ч {6495ED}Normal Ped.
{FFA500}60 Ч {6495ED}Normal Ped.
{FFA500}61 Ч {6495ED}Pilot.
{FFA500}62 Ч {6495ED}Colonel Fuhrberger.
{FFA500}63 Ч {6495ED}Prostitute.
{FFA500}64 Ч {6495ED}Prostitute.
{FFA500}65 Ч {6495ED}Kendl Johnson.
{FFA500}66 Ч {6495ED}Pool Player.
{FFA500}67 Ч {6495ED}Pool Player.
{FFA500}68 Ч {6495ED}Priest/Preacher.
{FFA500}69 Ч {6495ED}Normal Ped.
{FFA500}70 Ч {6495ED}Scientist.
{FFA500}71 Ч {6495ED}Security Guard.
{FFA500}72 Ч {6495ED}Hippy.
{FFA500}73 Ч {6495ED}Hippy.
{FFA500}75 Ч {6495ED}Prostitute.
{FFA500}76 Ч {6495ED}Stewardess.
{FFA500}77 Ч {6495ED}Homeless.
{FFA500}78 Ч {6495ED}Homeless.
{FFA500}79 Ч {6495ED}Homeless.
{FFA500}80 Ч {6495ED}Boxer.
{FFA500}81 Ч {6495ED}Boxer.
{FFA500}82 Ч {6495ED}Black Elvis.
{FFA500}83 Ч {6495ED}White Elvis.
{FFA500}84 Ч {6495ED}Blue Elvis.
{FFA500}85 Ч {6495ED}Prostitute.
{FFA500}86 Ч {6495ED}Ryder with robbery mask.
{FFA500}87 Ч {6495ED}Stripper.
{FFA500}88 Ч {6495ED}Normal Ped.
{FFA500}89 Ч {6495ED}Normal Ped.
{FFA500}90 Ч {6495ED}Jogger.
{FFA500}91 Ч {6495ED}Rich Woman.
{FFA500}92 Ч {6495ED}Rollerskater.
{FFA500}93 Ч {6495ED}Normal Ped.
{FFA500}94 Ч {6495ED}Normal Ped.
{FFA500}95 Ч {6495ED}Normal Ped.
{FFA500}96 Ч {6495ED}Jogger.
{FFA500}97 Ч {6495ED}Lifeguard.
{FFA500}98 Ч {6495ED}Normal Ped.
{FFA500}99 Ч {6495ED}Rollerskater.
{FFA500}100 Ч {6495ED}Biker.
{FFA500}101 Ч {6495ED}Normal Ped.
{FFA500}102 Ч {6495ED}Ballas 1.
{FFA500}103 Ч {6495ED}Ballas 2.
{FFA500}104 Ч {6495ED}Ballas 3.
{FFA500}105 Ч {6495ED}Grove Street Families 1.
{FFA500}106 Ч {6495ED}Grove Street Families 2.
{FFA500}107 Ч {6495ED}Grove Street Families 3.
{FFA500}108 Ч {6495ED}Los Santos Vagos 1.
{FFA500}109 Ч {6495ED}Los Santos Vagos 2.
{FFA500}110 Ч {6495ED}Los Santos Vagos 3.
{FFA500}111 Ч {6495ED}The Russian Mafia 1.
{FFA500}112 Ч {6495ED}The Russian Mafia 2.
{FFA500}113 Ч {6495ED}La Cosa Nostra 1.
{FFA500}114 Ч {6495ED}Varios Los Aztecas 1.
{FFA500}115 Ч {6495ED}Varios Los Aztecas 2.
{FFA500}116 Ч {6495ED}Varios Los Aztecas 3.
{FFA500}117 Ч {6495ED}Yakuza 1.
{FFA500}118 Ч {6495ED}Yakuza 2.
{FFA500}119 Ч {6495ED}Johhny Sindacco.
{FFA500}120 Ч {6495ED}Yakuza 3.
{FFA500}121 Ч {6495ED}Da Nang Boy 1.
{FFA500}122 Ч {6495ED}Da Nang Boy 2.
{FFA500}123 Ч {6495ED}Yakuza 4.
{FFA500}124 Ч {6495ED}La Cosa Nostra 2.
{FFA500}125 Ч {6495ED}The Russian Mafia 3.
{FFA500}126 Ч {6495ED}The Russian Mafia 4.
{FFA500}127 Ч {6495ED}La Cosa Nostra 3.
{FFA500}128 Ч {6495ED}Farm Inhabitant.
{FFA500}129 Ч {6495ED}Farm Inhabitant.
{FFA500}130 Ч {6495ED}Farm Inhabitant.
{FFA500}131 Ч {6495ED}Farm Inhabitant.
{FFA500}132 Ч {6495ED}Farm Inhabitant.
{FFA500}133 Ч {6495ED}Farm Inhabitant.
{FFA500}134 Ч {6495ED}Homeless.
{FFA500}135 Ч {6495ED}Normal Ped.
{FFA500}136 Ч {6495ED}Homeless.
{FFA500}137 Ч {6495ED}Beach Visitor.
{FFA500}138 Ч {6495ED}Beach Visitor.
{FFA500}139 Ч {6495ED}Beach Visitor.
{FFA500}140 Ч {6495ED}Beach Visitor.
{FFA500}141 Ч {6495ED}Businesswoman.
{FFA500}142 Ч {6495ED}Taxi Driver.
{FFA500}143 Ч {6495ED}Crack Maker.
{FFA500}144 Ч {6495ED}Crack Maker.
{FFA500}145 Ч {6495ED}Crack Maker.
{FFA500}146 Ч {6495ED}Crack Maker.
{FFA500}147 Ч {6495ED}Businesswoman.
{FFA500}148 Ч {6495ED}Businesswoman.
{FFA500}149 Ч {6495ED}Big Smoke Armored.
{FFA500}150 Ч {6495ED}Businesswoman.
{FFA500}151 Ч {6495ED}Normal Ped.
{FFA500}152 Ч {6495ED}Prostitute.
{FFA500}153 Ч {6495ED}Construction Worker.
{FFA500}154 Ч {6495ED}Beach Visitor.
{FFA500}155 Ч {6495ED}Well Stacked Pizza Worker.
{FFA500}156 Ч {6495ED}Barber.
{FFA500}157 Ч {6495ED}Hillbilly.
{FFA500}158 Ч {6495ED}Farmer.
{FFA500}159 Ч {6495ED}Hillbilly.
{FFA500}160 Ч {6495ED}Hillbilly.
{FFA500}161 Ч {6495ED}Farmer.
{FFA500}162 Ч {6495ED}Hillbilly.
{FFA500}163 Ч {6495ED}Black Bouncer.
{FFA500}164 Ч {6495ED}White Bouncer.
{FFA500}165 Ч {6495ED}White MIB agent.
{FFA500}166 Ч {6495ED}Black MIB agent.
{FFA500}167 Ч {6495ED}Cluckin' Bell Worker.
{FFA500}168 Ч {6495ED}Hotdog/Chilli Dog Vendor.
{FFA500}169 Ч {6495ED}Normal Ped.
{FFA500}170 Ч {6495ED}Normal Ped.
{FFA500}171 Ч {6495ED}Blackjack Dealer.
{FFA500}172 Ч {6495ED}Casino croupier.
{FFA500}173 Ч {6495ED}San Fierro Rifa 1.
{FFA500}174 Ч {6495ED}San Fierro Rifa 2.
{FFA500}175 Ч {6495ED}San Fierro Rifa 3.
{FFA500}176 Ч {6495ED}Barber.
{FFA500}177 Ч {6495ED}Barber.
{FFA500}179 Ч {6495ED}Whore.
{FFA500}180 Ч {6495ED}Ammunation Salesman.
{FFA500}181 Ч {6495ED}Tattoo Artist.
{FFA500}182 Ч {6495ED}Cab Driver.
{FFA500}183 Ч {6495ED}Normal Ped.
{FFA500}184 Ч {6495ED}Normal Ped.
{FFA500}185 Ч {6495ED}Normal Ped.
{FFA500}186 Ч {6495ED}Normal Ped.
{FFA500}187 Ч {6495ED}Businessman.
{FFA500}188 Ч {6495ED}Normal Ped.
{FFA500}189 Ч {6495ED}Valet.
{FFA500}190 Ч {6495ED}Barbara Schternvart.
{FFA500}191 Ч {6495ED}Helena Wankstein.
{FFA500}192 Ч {6495ED}Michelle Cannes.
{FFA500}193 Ч {6495ED}Katie Zhan.
{FFA500}194 Ч {6495ED}Millie Perkins.
{FFA500}195 Ч {6495ED}Denise Robinson.
{FFA500}196 Ч {6495ED}Farm-Town inhabitant.
{FFA500}197 Ч {6495ED}Hillbilly.
{FFA500}198 Ч {6495ED}Farm-Town inhabitant.
{FFA500}199 Ч {6495ED}Farm-Town inhabitant.
{FFA500}200 Ч {6495ED}Hillbilly.
{FFA500}201 Ч {6495ED}Farmer.
{FFA500}202 Ч {6495ED}Farmer.
{FFA500}203 Ч {6495ED}Karate Teacher.
{FFA500}204 Ч {6495ED}Karate Teacher.
{FFA500}205 Ч {6495ED}Burger Shot Cashier.
{FFA500}206 Ч {6495ED}Cab Driver.
{FFA500}207 Ч {6495ED}Prostitute.
{FFA500}208 Ч {6495ED}Su Xi Mu (Suzie).
{FFA500}209 Ч {6495ED}Oriental Noodle stand vendor.
{FFA500}210 Ч {6495ED}Boating School Instructor.
{FFA500}211 Ч {6495ED}Clothes shop staff.
{FFA500}212 Ч {6495ED}Homeless.
{FFA500}213 Ч {6495ED}Weird old man.
{FFA500}214 Ч {6495ED}Waitress (Maria Latore).
{FFA500}215 Ч {6495ED}Normal Ped.
{FFA500}216 Ч {6495ED}Normal Ped.
{FFA500}217 Ч {6495ED}Clothes shop staff.
{FFA500}218 Ч {6495ED}Normal Ped.
{FFA500}219 Ч {6495ED}Rich Woman.
{FFA500}220 Ч {6495ED}Cab Driver.
{FFA500}221 Ч {6495ED}Normal Ped.
{FFA500}222 Ч {6495ED}Normal Ped.
{FFA500}223 Ч {6495ED}Normal Ped.
{FFA500}224 Ч {6495ED}Normal Ped.
{FFA500}225 Ч {6495ED}Normal Ped.
{FFA500}227 Ч {6495ED}Oriental Businessman.
{FFA500}228 Ч {6495ED}Oriental Ped.
{FFA500}229 Ч {6495ED}Oriental Ped.
{FFA500}230 Ч {6495ED}Homeless.
{FFA500}231 Ч {6495ED}Normal Ped.
{FFA500}232 Ч {6495ED}Normal Ped.
{FFA500}233 Ч {6495ED}Normal Ped.
{FFA500}234 Ч {6495ED}Cab Driver.
{FFA500}235 Ч {6495ED}Normal Ped.
{FFA500}236 Ч {6495ED}Normal Ped.
{FFA500}237 Ч {6495ED}Prostitute.
{FFA500}238 Ч {6495ED}Prostitute.
{FFA500}239 Ч {6495ED}Homeless.
{FFA500}240 Ч {6495ED}The D.A.
{FFA500}241 Ч {6495ED}Afro-American.
{FFA500}242 Ч {6495ED}Mexican.
{FFA500}243 Ч {6495ED}Prostitute.
{FFA500}244 Ч {6495ED}Stripper.
{FFA500}245 Ч {6495ED}Prostitute.
{FFA500}246 Ч {6495ED}Stripper.
{FFA500}247 Ч {6495ED}Biker.
{FFA500}248 Ч {6495ED}Biker.
{FFA500}249 Ч {6495ED}Pimp.
{FFA500}250 Ч {6495ED}Normal Ped.
{FFA500}251 Ч {6495ED}Lifeguard.
{FFA500}252 Ч {6495ED}Naked Valet.
{FFA500}253 Ч {6495ED}Bus Driver.
{FFA500}254 Ч {6495ED}Biker Drug Dealer.
{FFA500}255 Ч {6495ED}Chauffeur (Limo Driver).
{FFA500}256 Ч {6495ED}Stripper.
{FFA500}257 Ч {6495ED}Stripper.
{FFA500}258 Ч {6495ED}Heckler.
{FFA500}259 Ч {6495ED}Heckler.
{FFA500}260 Ч {6495ED}Construction Worker.
{FFA500}261 Ч {6495ED}Cab driver.
{FFA500}262 Ч {6495ED}Cab driver.
{FFA500}263 Ч {6495ED}Normal Ped.
{FFA500}264 Ч {6495ED}Clown.
{FFA500}265 Ч {6495ED}Officer Frank Tenpenny.
{FFA500}266 Ч {6495ED}Officer Eddie Pulaski.
{FFA500}267 Ч {6495ED}Officer Jimmy Hernandez.
{FFA500}268 Ч {6495ED}Dwaine/Dwayne.
{FFA500}269 Ч {6495ED}Melvin "Big Smoke" Harris.
{FFA500}270 Ч {6495ED}Sean 'Sweet' Johnson.
{FFA500}271 Ч {6495ED}Lance 'Ryder' Wilson.
{FFA500}272 Ч {6495ED}The Russian Mafia Boss.
{FFA500}273 Ч {6495ED}T-Bone Mendez.
{FFA500}274 Ч {6495ED}Paramedic.
{FFA500}275 Ч {6495ED}Paramedic.
{FFA500}276 Ч {6495ED}Paramedic.
{FFA500}277 Ч {6495ED}Firefighter.
{FFA500}278 Ч {6495ED}Firefighter.
{FFA500}279 Ч {6495ED}Firefighter.
{FFA500}280 Ч {6495ED}Los Santos Police Officer.
{FFA500}281 Ч {6495ED}San Fierro Police Officer.
{FFA500}282 Ч {6495ED}Las Venturas Police Officer.
{FFA500}283 Ч {6495ED}County Sheriff.
{FFA500}284 Ч {6495ED}LSPD Motorbike Cop.
{FFA500}285 Ч {6495ED}SWAT Special Forces.
{FFA500}286 Ч {6495ED}Federal Agent.
{FFA500}287 Ч {6495ED}San Andreas Army.
{FFFFFF}288 Ч {6495ED}Desert Sheriff.
{FFA500}289 Ч {6495ED}Zero.
{FFA500}290 Ч {6495ED}Ken Rozenberg.
{FFA500}291 Ч {6495ED}Kent Paul.
{FFA500}292 Ч {6495ED}Cesar Vialpando.
{FFA500}293 Ч {6495ED}Jeffery "OG Loc" Martin/Cross.
{FFA500}294 Ч {6495ED}Wu Zi Mu (Woozie).
{FFA500}295 Ч {6495ED}Michael Toreno.
{FFA500}296 Ч {6495ED}Jizzy B.
{FFA500}297 Ч {6495ED}Madd Dogg.
{FFA500}298 Ч {6495ED}Catalina.
{FFA500}299 Ч {6495ED}Claude Speed.
{FFA500}300 Ч {6495ED}Los Santos Police Officer.
{FFA500}301 Ч {6495ED}San Fierro Police Officer.
{FFA500}302 Ч {6495ED}Las Venturas Police Officer.
{FFA500}303 Ч {6495ED}Los Santos Police Officer.
{FFA500}304 Ч {6495ED}Los Santos Police Officer.
{FFA500}305 Ч {6495ED}Las Venturas Police Officer.
{FFA500}306 Ч {6495ED}Los Santos Police Officer.
{FFA500}307 Ч {6495ED}San Fierro Police Officer.
{FFA500}308 Ч {6495ED}San Fierro Paramedic.
{FFA500}309 Ч {6495ED}Las Venturas Police Officer.
{FFA500}310 Ч {6495ED}Country Sheriff (Without hat).
{FFA500}311 Ч {6495ED}Desert Sheriff (Without hat).]], "{FFFFFF}ѕрин€ть", "", 4)
    end)
sampRegisterChatCommand("idcars", function()
        sampShowDialog(1, "{FFF000}ID транспортных средств", [[
{FFA500}400 Ч {6495ED}Landstalker.
{FFA500}401 Ч {6495ED}Bravura.
{FFA500}402 Ч {6495ED}Buffalo.
{FFA500}403 Ч {6495ED}Linerunner.
{FFA500}404 Ч {6495ED}Perennial.
{FFA500}405 Ч {6495ED}Sentinel.
{FFA500}406 Ч {6495ED}Dumper.
{FFA500}407 Ч {6495ED}Firetruck.
{FFA500}408 Ч {6495ED}Trashmaster.
{FFA500}409 Ч {6495ED}Stretch.
{FFA500}410 Ч {6495ED}Manana.
{FFA500}411 Ч {6495ED}Infernus.
{FFA500}412 Ч {6495ED}Voodoo.
{FFA500}413 Ч {6495ED}Pony.
{FFA500}414 Ч {6495ED}Mule.
{FFA500}415 Ч {6495ED}Cheetah.
{FFA500}416 Ч {6495ED}Ambulance.
{FFA500}417 Ч {6495ED}Leviathan.
{FFA500}418 Ч {6495ED}Moonbeam.
{FFA500}419 Ч {6495ED}Esperanto.
{FFA500}420 Ч {6495ED}Taxi.
{FFA500}421 Ч {6495ED}Washington.
{FFA500}422 Ч {6495ED}Bobcat.
{FFA500}423 Ч {6495ED}Mr. Whoopee.
{FFA500}424 Ч {6495ED}BF Injection.
{FFA500}425 Ч {6495ED}Hunter.
{FFA500}426 Ч {6495ED}Premier.
{FFA500}427 Ч {6495ED}Enforcer.
{FFA500}428 Ч {6495ED}Securi Car.
{FFA500}429 Ч {6495ED}Banshee.
{FFA500}430 Ч {6495ED}Predator.
{FFA500}431 Ч {6495ED}Bus.
{FFA500}432 Ч {6495ED}Rhino.
{FFA500}433 Ч {6495ED}Barracks.
{FFA500}434 Ч {6495ED}Hotknife.
{FFA500}435 Ч {6495ED}Article Trailer.
{FFA500}436 Ч {6495ED}Previon.
{FFA500}437 Ч {6495ED}Coach.
{FFA500}438 Ч {6495ED}Cabbie.
{FFA500}439 Ч {6495ED}Stallion.
{FFA500}440 Ч {6495ED}Rumpo.
{FFA500}441 Ч {6495ED}RC Bandit.
{FFA500}442 Ч {6495ED}Romero.
{FFA500}443 Ч {6495ED}Packer.
{FFA500}444 Ч {6495ED}Monster.
{FFA500}445 Ч {6495ED}Admiral.
{FFA500}446 Ч {6495ED}Squallo.
{FFA500}447 Ч {6495ED}Seasparrow.
{FFA500}448 Ч {6495ED}Pizzaboy.
{FFA500}449 Ч {6495ED}Tram.
{FFA500}450 Ч {6495ED}Article Trailer 2.
{FFA500}451 Ч {6495ED}Turismo.
{FFA500}452 Ч {6495ED}Speeder.
{FFA500}453 Ч {6495ED}Reefer.
{FFA500}454 Ч {6495ED}Tropic.
{FFA500}455 Ч {6495ED}Flatbed.
{FFA500}456 Ч {6495ED}Yankee.
{FFA500}457 Ч {6495ED}Caddy.
{FFA500}458 Ч {6495ED}Solair.
{FFA500}459 Ч {6495ED}Topfun Van (Berkley's RC).
{FFA500}460 Ч {6495ED}Skimmer.
{FFA500}461 Ч {6495ED}PCJ-600.
{FFA500}462 Ч {6495ED}Faggio.
{FFA500}463 Ч {6495ED}Freeway.
{FFA500}464 Ч {6495ED}RC Baron.
{FFA500}465 Ч {6495ED}RC Raider.
{FFA500}466 Ч {6495ED}Glendale.
{FFA500}467 Ч {6495ED}Oceanic.
{FFA500}468 Ч {6495ED}Sanchez.
{FFA500}469 Ч {6495ED}Sparrow.
{FFA500}470 Ч {6495ED}Patriot.
{FFA500}471 Ч {6495ED}Quad.
{FFA500}472 Ч {6495ED}Coastguard.
{FFA500}473 Ч {6495ED}Dinghy.
{FFA500}474 Ч {6495ED}Hermes.
{FFA500}475 Ч {6495ED}Sabre.
{FFA500}476 Ч {6495ED}Rustler.
{FFA500}477 Ч {6495ED}ZR-350.
{FFA500}478 Ч {6495ED}Walton.
{FFA500}479 Ч {6495ED}Regina.
{FFA500}480 Ч {6495ED}Comet.
{FFA500}481 Ч {6495ED}BMX.
{FFA500}482 Ч {6495ED}Burrito.
{FFA500}483 Ч {6495ED}Camper.
{FFA500}484 Ч {6495ED}Marquis.
{FFA500}485 Ч {6495ED}Baggage.
{FFA500}486 Ч {6495ED}Dozer.
{FFA500}487 Ч {6495ED}Maverick.
{FFA500}488 Ч {6495ED}SAN News Maverick.
{FFA500}489 Ч {6495ED}Rancher.
{FFA500}490 Ч {6495ED}FBI Rancher.
{FFA500}491 Ч {6495ED}Virgo.
{FFA500}492 Ч {6495ED}Greenwood.
{FFA500}493 Ч {6495ED}Jetmax.
{FFA500}494 Ч {6495ED}Hotring Racer.
{FFA500}495 Ч {6495ED}Sandking.
{FFA500}496 Ч {6495ED}Blista Compact.
{FFA500}497 Ч {6495ED}Police Maverick.
{FFA500}498 Ч {6495ED}Boxville.
{FFA500}499 Ч {6495ED}Benson.
{FFA500}500 Ч {6495ED}Mesa.
{FFA500}501 Ч {6495ED}RC Goblin.
{FFA500}502 Ч {6495ED}Hotring Racer A.
{FFA500}503 Ч {6495ED}Hotring Racer B.
{FFA500}504 Ч {6495ED}Bloodring Banger.
{FFA500}505 Ч {6495ED}Rancher Lure.
{FFA500}506 Ч {6495ED}Super GT.
{FFA500}507 Ч {6495ED}Elegant.
{FFA500}508 Ч {6495ED}Journey.
{FFA500}509 Ч {6495ED}Bike.
{FFA500}510 Ч {6495ED}Mountain Bike.
{FFA500}511 Ч {6495ED}Beagle.
{FFA500}512 Ч {6495ED}Croapduster.
{FFA500}513 Ч {6495ED}Stuntplane.
{FFA500}514 Ч {6495ED}Tanker.
{FFA500}515 Ч {6495ED}Roadtrain.
{FFA500}516 Ч {6495ED}Nebula.
{FFA500}517 Ч {6495ED}Majestic.
{FFA500}518 Ч {6495ED}Buccaneer.
{FFA500}519 Ч {6495ED}Shamal.
{FFA500}520 Ч {6495ED}Hydra.
{FFA500}521 Ч {6495ED}FCR-900.
{FFA500}522 Ч {6495ED}NRG-500.
{FFA500}523 Ч {6495ED}HPV1000.
{FFA500}524 Ч {6495ED}Cement Truck.
{FFA500}525 Ч {6495ED}Towtruck.
{FFA500}526 Ч {6495ED}Fortune.
{FFA500}527 Ч {6495ED}Cadrona.
{FFA500}528 Ч {6495ED}FBI Truck.
{FFA500}529 Ч {6495ED}Willard.
{FFA500}530 Ч {6495ED}Forklift.
{FFA500}531 Ч {6495ED}Tractor.
{FFA500}532 Ч {6495ED}Combine Harvester.
{FFA500}533 Ч {6495ED}Feltzer.
{FFA500}534 Ч {6495ED}Remington.
{FFA500}535 Ч {6495ED}Slamvan.
{FFA500}536 Ч {6495ED}Blade.
{FFA500}537 Ч {6495ED}Freight (Train).
{FFA500}538 Ч {6495ED}Brownstreak (Train).
{FFA500}539 Ч {6495ED}Vortex.
{FFA500}540 Ч {6495ED}Vincent.
{FFA500}541 Ч {6495ED}Bullet.
{FFA500}542 Ч {6495ED}Clover.
{FFA500}543 Ч {6495ED}Sadler.
{FFA500}544 Ч {6495ED}Firetruck LA.
{FFA500}545 Ч {6495ED}Hustler.
{FFA500}546 Ч {6495ED}Intruder.
{FFA500}547 Ч {6495ED}Primo.
{FFA500}548 Ч {6495ED}Cargobob.
{FFA500}549 Ч {6495ED}Tampa.
{FFA500}550 Ч {6495ED}Sunrise.
{FFA500}551 Ч {6495ED}Merit.
{FFA500}552 Ч {6495ED}Utility Van.
{FFA500}553 Ч {6495ED}Nevada.
{FFA500}554 Ч {6495ED}Yosemite.
{FFA500}555 Ч {6495ED}Windsor.
{FFA500}556 Ч {6495ED}Monster "A".
{FFA500}557 Ч {6495ED}Monster "B".
{FFA500}558 Ч {6495ED}Uranus.
{FFA500}559 Ч {6495ED}Jester.
{FFA500}560 Ч {6495ED}Sultan.
{FFA500}561 Ч {6495ED}Stratum.
{FFA500}562 Ч {6495ED}Elegy.
{FFA500}563 Ч {6495ED}Raindance.
{FFA500}564 Ч {6495ED}RC Tiger.
{FFA500}565 Ч {6495ED}Flash.
{FFA500}566 Ч {6495ED}Tahoma.
{FFA500}567 Ч {6495ED}Savanna.
{FFA500}568 Ч {6495ED}Bandito.
{FFA500}569 Ч {6495ED}Freight Flat Trailer (Train.
{FFA500}570 Ч {6495ED}Streak Trailer (Train).
{FFA500}571 Ч {6495ED}Kart.
{FFA500}572 Ч {6495ED}Mower.
{FFA500}573 Ч {6495ED}Dune.
{FFA500}574 Ч {6495ED}Sweeper.
{FFA500}575 Ч {6495ED}Broadway.
{FFA500}576 Ч {6495ED}Tornado.
{FFA500}577 Ч {6495ED}AT400.
{FFA500}578 Ч {6495ED}DFT-30.
{FFA500}579 Ч {6495ED}Huntley.
{FFA500}580 Ч {6495ED}Stafford.
{FFA500}581 Ч {6495ED}BF-400.
{FFA500}582 Ч {6495ED}Newsvan.
{FFA500}583 Ч {6495ED}Tug.
{FFA500}584 Ч {6495ED}Petrol Trailer.
{FFA500}585 Ч {6495ED}Emperor.
{FFA500}586 Ч {6495ED}Wayfarer.
{FFA500}587 Ч {6495ED}Euros.
{FFA500}588 Ч {6495ED}Hotdog.
{FFA500}589 Ч {6495ED}Club.
{FFA500}590 Ч {6495ED}Freight Box Trailer (Train).
{FFA500}591 Ч {6495ED}Article Trailer 3.
{FFA500}592 Ч {6495ED}Andromada.
{FFA500}593 Ч {6495ED}Dodo.
{FFA500}594 Ч {6495ED}RC Cam.
{FFA500}595 Ч {6495ED}Launch.
{FFA500}596 Ч {6495ED}Police Car (LSPD).
{FFA500}597 Ч {6495ED}Police Car (SFPD).
{FFA500}598 Ч {6495ED}Police Car (LVPD).
{FFA500}599 Ч {6495ED}Police Ranger.
{FFA500}600 Ч {6495ED}Picador.
{FFA500}601 Ч {6495ED}SWAT.
{FFA500}602 Ч {6495ED}Alpha.
{FFA500}603 Ч {6495ED}Phoenix.
{FFA500}604 Ч {6495ED}Glendale Shit.
{FFA500}605 Ч {6495ED}Sadler Shit.
{FFA500}606 Ч {6495ED}Baggage Trailer "A".
{FFA500}607 Ч {6495ED}Baggage Trailer "B".
{FFA500}608 Ч {6495ED}Tug Stairs Trailer.
{FFA500}609 Ч {6495ED}Boxville 2.
{FFA500}610 Ч {6495ED}Farm Trailer.
{FFA500}611 Ч {6495ED}Utility Trailer.]], "{FFFFFF}ѕрин€ть", "", 4)
    end)
sampRegisterChatCommand("mphelp", function()
sampShowDialog(1, "{FFF000}ѕравила проведени€ меропри€тий", [[
I. {F0E68C}ќсновные правила проведени€ меропри€тий:
{FF8C00}1.1. {4169E1}јдминистратор может провести меропри€тие, если у него есть свободное врем€ от слежки за игроками.
{FF8C00}1.2. {4169E1}јдминистраторам разрешаетс€ принимать участие на меропри€ти€х: "PaintBall", "–усска€ рулетка".
{FF8C00}1.3. {4169E1}јдминистратор, который хочет провести меропри€тие, должен узнать, зан€то ли /aad, /mp.
{FF8C00}1.4. {4169E1}јдминистраторам, у которых есть доступ к команде "/givebilet" - ...
{FF8C00}... {4169E1}разрешаетс€ проводить неограниченное количество меропри€тий до 5 Luxwen-билетов.
{FF8C00}1.5. {4169E1}јдминистратор, который будет проводить меропри€тие...
{FF8C00}... {4169E1}должен указать тег при отправке админ. объ€влени€: {FFD700}/msg [ћѕ].
{FF8C00}1.6. {4169E1}јдминистратор, который будет проводить меропри€тие, должен указать:
{FF8C00}... {4169E1}название меропри€ти€, наименование приза.
ѕример: ћѕ | ѕроходит меропри€тие Ч "–усска€ рулетка". ѕриз: 2 Luxwen билета(/gomp).
{FF8C00}1.7. {4169E1}Ќезнание правил проведени€ меропри€тий не освобождает ¬ас от ответственности.

{FF8C00}II. {4169E1}–азрешаетс€ во врем€ проведени€ меропри€тий:
{FF8C00}2.1. {4169E1}ѕроводить свои меропри€ти€, которые не нарушают правила сервера.
{FF8C00}2.2. {4169E1}ѕроводить меропри€ти€ на ƒонат-очки, скины, VIP статус, дома, автомобили, Luxwen-билеты, игровые деньги.
{FF8C00}2.3. {4169E1}ѕроводить меропри€ти€ с одним администратором, который может вз€ть к себе на помощь.
{FF8C00}2.4. {4169E1}ѕроводить меропри€ти€ через общий чат (/aad или /msg)...
{FF8C00}... {4169E1}но при этом, ответы не должны приходить через репорт, а через SMS провод€щему меропри€тие администратору.
{FF8C00}2.5. {4169E1} икнуть/посадить игрока, если тот нарушает правила сервера и установленные правила администратором.
{FF8C00}2.6. {4169E1}«апустить серверное меропри€тие.
{FF8C00}2.7. {4169E1}ѕроводить меропри€тие совместно с другими игроками (спонсоры меропри€ти€).
{FFFFFF}
{FF8C00}III. {4169E1}«апрещаетс€ во врем€ проведени€ меропри€тий:
{FF8C00}3.1. {4169E1}”частвовать на меропри€тии, если не получил согласие на участие от организатора меропри€ти€.
{FF8C00}3.2. {4169E1}«апрещаетс€ проводить меропри€ти€ на тот приз, которые не можете выдать.
{FF8C00}3.3. {4169E1}«апрещаетс€: мешать/телепортироватьс€/спавнить/убивать организатора меропри€ти€.
{FF8C00}3.4. {4169E1}«апрещаетс€ спавнить/убивать игрока без причины.
{FF8C00}3.5. {4169E1}«апрещаетс€ мен€ть приз, правила меропри€ти€.
{FF8C00}3.6. {4169E1}«апрещаетс€ помогать игроку во врем€ меропри€ти€.
{FF8C00}3.7. {4169E1}«апрещаетс€ проводить другое меропри€тие, если меропри€тие проводит уже другой администратор.
{FF8C00}3.8. {4169E1}«апрещаетс€ проводить меропри€ти€ через репорт.
{FF8C00}3.9. {4169E1}«апрещаетс€ проводить меропри€ти€ на: админ. права, права лидера...
{FF8C00}... {4169E1}права агента поддержки (может провести только от «√— за агентами поддержки), рубли.
{FFFFFF}
{FFD700} оманды дл€ проведени€ меропри€ти€:
 /mp Ч {FF8C00}меню по проведению меропри€ти€.
 /settp Ч {FF8C00}открыть/закрыть точку телепорта дл€ телепортации на меропри€ти€.
 /mpwin Ч {FF8C00}выдать ƒонат-очки.
 /givebilet Ч {FF8C00}выдать Luxwen-билет.
 /startpb Ч {FF8C00}запустить PaintBall.
 /startrace Ч {FF8C00}запустить √онки.
 /startbase Ч {FF8C00}запустить Ѕейсджампинг.
]], "{FFFFFF}ѕрин€ть", "", 4)
    end)
sampRegisterChatCommand("obi", function()
        sampShowDialog(5, " ", [[
{FFD700}/apm Ч {FFFFFF}автоответчик.
{FFD700}/anak Ч {FFFFFF}правила выдачи наказаний.
{FFD700}/aprav Ч {FFFFFF}правила администрации.
{FFD700}/mphelp Ч {FFFFFF}правила проведени€ меропри€тий.
{FFD700}/predit Ч {FFFFFF}правила редактировани€ объ€влений.
{FFD700}/hrep Ч {FFFFFF}посмотреть информацию о системе повышени€.
{FFD700}/ahelp Ч {FFFFFF}посмотреть весь список команд администрации со значением.
{FFF000}/top Ч {FFFFFF}“ќѕ администраторов.
{FFD700}/staff Ч {FFFFFF}список старшей администрации.
{FFD700}/html Ч {FFFFFF}HTML цвета.
{FFD700}/idguns Ч {FFFFFF}ID оружи€.
{FFD700}/idcars Ч {FFFFFF}ID транспортных средств.
{FFD700}/idskins Ч {FFFFFF}ID скинов.
{FFD700}/fid Ч {FFFFFF}ID организаций.
{FFD700}/info Ч {FFFFFF}посмотреть информацию.
]], "{FFFFFF}ѕрин€ть", "", 0)
    end)
sampRegisterChatCommand("fid", function()
        sampShowDialog(2, "—писок организаций", [[
{FFFFFF}1. {4169E1}LSPD
{FFFFFF}2. {2e2c2c}FBI
{7FFFD4}3. {A0522D}јрми€ јвианосец
{7FFFD4}4. {DB7093}Ѕольница г. Ћос-—антос
{FFFFFF}5. {DAA520}La Cosa Nostra
{FFFFFF}6. {FF0000}Yakuza
{FFFFFF}7. {4682B4}ћэри€
{7FFFD4}10. {4169E1}RCSD
{FFFFFF}12. {9400D3}East Side Ballas
{FFFFFF}13. {FFD700}Los Santos Vagos
{FFFFFF}14. {D3D3D3}Russian Mafia
{FFFFFF}15. {228B22}West Side Grove
{7FFFD4}16. {FF8C00}Sa News
{FFFFFF}17. {00FFFF}Varrios Los Aztecas
{FFFFFF}18. {6495ED}East Coast Rifa
{FFFFFF}19. {A0522D}јрми€ г. Ћос-—антос
{7FFFD4}21. {4169E1}NATD
{FFFFFF}23. {A9A9A9}Hitmans
{FFFFFF}25. {2E8B57}SWAT
{FFFFFF}26. {FFFF00}јдминистраци€ ѕрезидента]], "{FFFFFF}ѕрин€ть", "", 0)
    end)
sampRegisterChatCommand("info", function()
        sampShowDialog(5, "{FFF000}»нформаци€", [[
{FFD700}ѕоддержка скрипта прекращена.

{FFFFFF}_________________________________________________

{FFFFFF}¬ онтакте создател€: {FFFFFF}vk.com/obikenobii.
{FFFFFF}ѕоследнее обновление:{FF8C00} 4 марта 2022.
{FFFFFF}—писок команд: {FFFFFF}/obi

]], "{FFFFFF}ѕрин€ть", "", 0)
    end)
sampRegisterChatCommand("staff", function()
        sampShowDialog(5, "{FFf000}јдминистраци€", [[
{FF0000} ќснователь {FFFFFF}Ч Cavallaro ({4169E1}vk.com/cavallaro13{FFFFFF}).
{FF0000} ќснователь {FFFFFF}Ч Saxarok ({4169E1}vk.com/os170{FFFFFF}).
{FF0000} «аместитель основател€ {FFFFFF}Ч Ademi_Bala ({4169E1}vk.com/rm_ramil{FFFFFF}).
{FF0000} ѕомощник «ам. основател€ {FFFFFF}Ч Kenobi ({4169e1}vk.com/obikenobii{FFFFFF}).

{2681ff} √лавный администратор {FFFFFF}Ч iceberg ({4169E1}vk.com/obikenobii{FFFFFF}).
{8A2BE2} «аместитель √лавного администратора {FFFFFF}Ч Blayze_Scaletta({4169E1}vk.com/ugenrl{FFFFFF}).

{8B0000}  уратор Ќелегальных организаций {FFFFFF}Ч Blayze_Noufam ({4169E1}vk.com/ugenrl{FFFFFF}).
{008080}  уратор √осударственных структур {FFFFFF}Ч -({4169E1}vk.com/{FFFFFF}).

{AFEEEE} √лавный след€щий за √осударственными структурами {FFFFFF}Ч Angelo_Santini({4169E1}vk.com/kortese{FFFFFF}).
{228b22} √лавный след€щий за Ѕандитскими группировками {FFFFFF}Ч Pablo_Parlament ({4169E1}vk.com/tom_torres{FFFFFF}).
{A0522D} √лавный след€щий за ћафиозными синдикатами {FFFFFF}Ч Shay_Danoe ({4169E1}vk.com/jopareal{FFFFFF}).
]], "{FFFFFF}ѕрин€ть", "", 0)
    end)
sampRegisterChatCommand("правила", function()
        sampShowDialog(5, "{FF0000}ѕравила администрации", [[
{FF0000}ѕоследнее обновление {FFFFFF}04.03.2022
{FFD700}ќб€занности администратора на сервере:
{FFD700}Ч {FFFFFF}јдминистратор об€зан помогать игрокам сервера если они прос€т их в /rep.
{FFD700}Ч {FFFFFF}јдминистратор об€зан за 1 день отыграть 120 минут, а так-же ответить за день как минимум на 50 репортов.
{FFD700}Ч {FFFFFF}јдминистратор об€зан просматривать форум, после выдачи наказани€ игроку.
{FFD700}Ч {FFFFFF}јдминистратор об€зан быть грамотным, уметь правильно, вежливо и грамотно формулировать свою речь.
{FFD700}Ч {FFFFFF}јдминистратор об€зан строить о себе хорошее впечатление - дл€ игроков, так и дл€ старшей администрации.
{FFD700}Ч {FFFFFF}јдминистратор об€зан иметь доказательства на нарушение со стороны игрока.
{FFD700}Ч {FFFFFF}јдминистратор об€зан сообщить старшей администрации о нарушение любого из јдминистратора.
{FFD700}Ч {FFFFFF}јдминистратор об€зан соблюдать ежедневную норму игрового онлайна - 120 минут и более.
{FFD700}Ч {FFFFFF}јдминистратор об€зан при выдаче наказани€ иметь доказательства нарушени€.
{FFD700}Ч {FFFFFF}јдминистратор об€зан вежливо обращатьс€ с игроками сервера, даже если игрок ваш ¬раг.
{FFD700}Ч {FFFFFF}јдминистратор об€зан следовать указани€м и слушать тех кто выше его рангом.
{FFD700}Ч {FFFFFF}јдминистратор об€зан в /msg - /o вначале писать тэг. Ќапример: [ћѕ], [ќ“Ѕќ–], [INFO] и тому подобное.
{FFD700}Ч {FFFFFF}јдминистратор, об€зан сдать тест на знание правил /aedit √лавной администрации, чтобы редактировать объ€влени€.
{FFD700}Ч {FFFFFF}јдминистратор об€зан в срочном пор€дке перейти в слежку за игроком, если игрок.
{FF0000}* {FFFFFF}Ќайти правила можно в разделе {228b22}FAQ{FFFFFF}, на форуме.
{FF0000}* {FFFFFF}јдминистратору запрещаетс€ прогуливать рабочий день:
- ѕонедельник - ѕ€тница: 11:00 > 22:00.
- —уббота - ¬оскресенье: 09:00 > 22:30. Ќаказание: ¬ыговор.

{FFD700}ѕравила администрации на сервере:
{FFFFFF}јдминистратору запрещаетс€:
ѕравила администрации на сервере:
{6495ED}Ч {FFFFFF}Ѕездействие, отсутствие работы, игнор репорта.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ снимать себе выговоры, выдавать себе рубли (FD).
Ќаказание: на усмотрение гл. администрации.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выдавать, снимать кому-либо префикс.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ писать в /o, /aad информацию, не имеющую смысл.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ "ќтправл€ть" объ€влени€ (/aedit), если они не были проверены по стандарту.
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ редактировать объ€влени€ (/aedit), если он не сдал тест у √лавной администрации.
Ќаказание: 2 выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ наказывать игроков с Non-RP никами (/uval если во фракции).
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ ругатьс€ матом при игре на сервере.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ ругатьс€ матом в админ. чате.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ пользоватьс€ читами до 4 уровн€.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ оскорбл€ть игроков сервера.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ разглашать админ-информацию.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выдавать наказани€ из личной непри€зни.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ угрожать игрокам сервера.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ распростран€ть блат на сервере.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ находитс€ в ј‘  более 50-ти минут.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору (от должности «√—+) запрещаетс€ сто€ть в ј‘  более 30 минут.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ измен€ть игровой Nick_Name чаще, чем раз в мес€ц, а так же не предупредив главную администрацию.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ находитс€ на посту лидера/администратора на другом сервере.
Ќаказание: сн€тие + чЄрный список.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ проводить слив сервера.
Ќаказание: сн€тие + блокировка аккаунта + чЄрный список.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ телепортироватьс€ к старшему составу администрации(ќснователь, √ј, «√ј), без их разрешени€.
 Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выпрашивать что-либо у главной администрации.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ оставл€ть за собой созданные т/с.
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ продавать ViP транспорт за рубли.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ мен€ть ник без ведома главной администрации.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выдавать больше 3-Єх билетов игроку.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выдавать любые наказани€ игроку/администратору с неадекватной причиной.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ кататьс€ на машине с кем-либо (бездействие).
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ вредить игроку (врезатьс€ в него/телепортироватьс€ к нему/к себе без причины/спавнить).
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ баловатьс€ какими-либо командами.
Ќаказание: лишение команды, задание от √ј, 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ покидать пост «аместител€ √лавного —лед€щего, не просто€в 21 день.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ присваивать себе префикс, не соответствующей своей должности.
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ присваивать префикс администратору, не соответствующей его должности.
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выдавать префикс, без разрешени€ √лавной администрации (от «√ј).
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выдавать наказание игроку с причиной "1", "досвидани€", "bb" и что-то на подобии этого.
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ иметь бизнес.
Ќаказание: выговор.
{FF0000}Ч {FFFFFF}јдминистратору запрещаетс€ иметь дом: в г. Ћос-—антос, элитной деревне Green Town.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ вмешиватьс€ в RolePlay процесс. Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ находитс€ на посту јгента ѕоддержки(’елпера).
»сключение: след€щие за јгентами ѕоддержки.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ иметь твинк. Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ использовать скин CJ [!] »сключение: —тарша€ јдминистраци€.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ находитс€ в ƒћ-«оне во врем€ рабочего дн€.
Ќаказание: 2 выговора
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ вмешательство в различные сферы де€тельности админов (√ос.фракции, хелперы, мафии, банды).
Ќаказание: 2 выговора
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ разглашать промо-коды любыми способами св€зи(/pm , /a, /sms и т.д).
Ќаказание: 2 выговора
{6495ED}Ч {FFFFFF}јдминистрации запрещено участвовать в ћеропри€ти€х и получать какие-либо призы в них.
Ќаказание: выговор(»сключение: разрешение от старшей администраций)
{6495ED}Ч {FFFFFF}јдминистрации запрещаетс€ спавнить игроков без причины.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистрации запрещаетс€ сбивать "кд" захватов территорий при отсутствии след€щих.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ отвечать в темах раздела "∆алобы на јдминистраторов",
если жалоба составлена на другого администратора.
Ќаказание: выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ распростран€ть запрещЄнные команды (/ucc,/slp, /crash).
Ќаказание: 2 выговора
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ телепортироватьс€ к старшей администрации без разрешени€.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ телепортировать к себе старшую администрацию.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ телепортировать к себе игрока без весомых причин.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ слапать/спавнить другого администратора без причины.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ использовать команду /skick,/kick в личных цел€х.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ банить/варнить/кикать другого администратора из личной непри€зни.
Ќаказание: выговор/сн€тие
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ провоцировать другого администратора/игрока.
Ќаказание: выговор
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ превышать свои полномочи€.
Ќаказание: 2 выговора
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ вести себ€ неадекватно в темах на форуме(капсить, материтьс€, вести себ€ неподобающе).
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ неуважительно общатьс€ с игроками на форуме (Ќе материтс€, не оскорбл€ть).
Ќаказание: ѕредупреждение на форумный аккаунт и выговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выражатьс€ нецензурной бранью в /a.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ выдавать себе запрещенное оружие любыми способами(включа€ читы).
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ поддерживать дружеские отношени€ на сервере с игроками,
состо€вшими в „Єрном списке проекта (искл. дела, не касающиес€ сервера Luxwen Role Play, игроки).
Ќаказание: сн€тие (возможен чс проекта).
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ давать ответ на репорт некорректно.
Ќаказание: ¬ыговор.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ плохо высказыватьс€ об сервере.
Ќаказание: сн€тие.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ допускать читеров/оскорблени€ в сторону проекта.
Ќаказание: 2 выговора.
{6495ED}Ч {FFFFFF}јдминистратору запрещаетс€ обсуждать действи€ √лавной администрации.
Ќаказание: на усмотрение.
]], "{FFFFFF}ѕрин€ть", "", 5)
    end)
sampRegisterChatCommand("predit", function()
        sampShowDialog(1, " ", [[
{00FA9A}I. ќсновные правила.
{00FA9A}1.1. {FFFFFF}Ќезнание правил не освобождает от ответственности.
{00FA9A}1.2. {FFFFFF}¬ каждом редактируемом объ€влении, не должно быть ћ√-информации.
{00FA9A}1.3. {FFFFFF}ќбъ€влени€ не должны пропускатьс€.
{00FA9A}1.4. {FFFFFF}ѕри указании суммы, пишетс€: тыс.; млн.; млрд. Luxwen-билет: билет. (1к - тыс., 1кк - млн., 1ккк - млрд.).
{FFD700}ѕример: {FFFFFF} уплю дом в любой точке штата. Ѕюджет: 100 тыс. вирт.
{FFD700}ѕример: {FFFFFF}ѕродам дом в г. Ћос-—антос. ÷ена: 3 билета.
{00FA9A}1.5. {FFFFFF}–азрешено использовать цветные объ€влени€ (HTML цвета).

{FF69B4}II. {FFFFFF}ѕравила редактировани€.
{FF69B4}2.1. {FFFFFF}—одержание объ€влени€ не должно быть изменено, а отредактировано по правилам.
{FF69B4}2.2. {FFFFFF}√орода пишутс€ на русском €зыке, названи€ транспортных средств - на английском €зыке.
{FF69B4}2.3. {FFFFFF}ќбъ€влени€ не должны быть отредактированы с ошибками.
{FF69B4}2.4. {FFFFFF}¬ названии транспортных средств, используютс€ кавычки (").

{9acd32}III. {FFFFFF}ѕравила купли/продажи товаров.
{9acd32}3.1. {FFFFFF}ѕри покупке чего-либо, пишетс€: Ѕюджет: сумма. (если бюджет не указан, то Ѕюджет: свободный).
{9acd32}3.2. {FFFFFF}ѕри продаже чего-либо, пишетс€ ÷ена: сумма. (если цена не указано, то ÷ена: договорна€).
{9acd32}3.3. {FFFFFF}ѕри продаже/покупке недвижимости, об€зательно должно быть местоположение.
{9acd32}3.4. {FFFFFF}ѕри продаже/покупке бизнеса, об€зательно должно быть название бизнеса и его расположение.
{9acd32}3.5. {FFFFFF}ѕри продаже/покупке транспортного средства, об€зательна должна быть марка.
(если не указана, то: а/м - автомобиль, м/ц - мотоцикл, в/т - вертолЄт, с/м - самолЄт, т/с - транспортное средство).
{9acd32}3.6. {FFFFFF}≈сли при покупке недвижимости, бизнеса, не указано его местоположение, то пишетс€: в любой точке штата.

{32CD32}IV. {FFFFFF}«амена слов.
{32CD32}4.1. {FFFFFF}√етто - опасный район.
{32CD32}4.2. {FFFFFF}GPS - Ќавигатор.
{32CD32}4.3. {FFFFFF}—кин ID - ќдежда по биркой.
{32CD32}4.4. {FFFFFF}Cкин - ќдежда.
{32CD32}4.5. {FFFFFF}ћодификаци€ - сувенир.

{ADFF2F}V. {FFFFFF}√орода и деревни, острова.
{ADFF2F}5.1. √орода сокращаютс€ на "г.".
{ADFF2F}5.2. ƒеревни сокращаютс€ на "д.".
{ADFF2F}5.3. √оры не сокращаютс€.
{ADFF2F}5.4. ќстров сокращаетс€ на "о."
{FFD700}Ќазвание городов, деревень, островов:
{ADFF2F}г. {FFFFFF}Ћос-—антос.
{ADFF2F}г. {FFFFFF}—ан-‘иерро.
{ADFF2F}г. {FFFFFF}Ћас-¬ентурас.
{ADFF2F}горе {FFFFFF}VineWood.
{ADFF2F}д. {FFFFFF}ѕаломино- рик.
{ADFF2F}д. {FFFFFF}ƒиллимор.
{ADFF2F}д. {FFFFFF}ћонтгомери.
{ADFF2F}д. {FFFFFF}‘орт- арсон
{ADFF2F}д. {FFFFFF}Ёнджелпайн.
{ADFF2F}о. {FFFFFF}Family.

{FF1493}VI. {FFFFFF}—окращени€.
{FF1493}6.1.{FFFFFF} а/м - автомобиль.
{FF1493}6.2. {FFFFFF}м/ц - мотоцикл.
{FF1493}6.3. {FFFFFF}с/м - самолЄт.
{FF1493}6.4.{FFFFFF} в/т - вертолЄт.
{FF1493}6.5. {FFFFFF}а/с - аксессуар.

{F4A460}VII. {FFFFFF}—обеседовани€.
{F4A460}7.1. {FFFFFF}¬ гос. фракции не редактируютс€ объ€влени€.
{F4A460}7.2. {FFFFFF}—обеседовани€ дл€ банд:
{FFFFFF}ѕроходит собеседование в футбольный клуб - East Side Ballas/Los Santos Vagos/West Side Grove/Varrios Los Aztecas/East Coast Rifa, прибыть на район.
{F4A460}7.3. {FFFFFF}—обеседовани€ дл€ мафий:
{FFFFFF}ѕроходит собеседование в гольф-клуб/ресторан/„ќѕ "La Cosa Nostra/Yakuza/Russian Mafia", прибыть на ма€к.
{FFFFFF}ѕроходит собеседование в похоронное агентство "Hitmans", прибыть на ма€к.

{DC143C}VIII. {FFFFFF}ѕоиск людей.
{DC143C}8.1. {FFFFFF}ѕоиск семьи разрешЄн.
{FFD700}ѕример: {FFFFFF}—емь€ "—итхи" ищет дальних родственников. ѕросьба св€затьс€.
{DC143C}8.2. {FFFFFF}ѕоиск людей разрешЄн.
ѕример: {FFFFFF}»щу человека под именем "Nick Name". ѕросьба св€затьс€.

{FF0000}¬—≈ ѕ–»ћ≈–џ –≈ƒј “»–ќ¬јЌ»я:
{FFFFFF} уплю дом в опасном районе. Ѕюджет: 2 млн. вирт.
ѕроходит собеседование в футбольный клуб ''Varrios Los Aztecas''. Ќавигатор: 1-1.
ѕродам одежду под биркой: "186". ÷ена: договорна€.
 уплю одежду "Woo Zie Mu", Ѕюджет: свободный.
 уплю сувенир "ѕризрак". Ѕюджет: свободный.

 уплю дом в г. Ћос-—антос. Ѕюджет: свободный.
 уплю а/м марки "Infernus". Ѕюджет: 500 млн. вирт.
 уплю б/з "ј«—" в любой точке штата. Ѕюджет: 2 млрд. вирт.
ѕродам б/з "24/7" в г. —ан-‘иерро. ÷ена: 900 тыс. вирт.
ѕродам в/т марки "Maverick". ÷ена: 180 млн. вирт.
 уплю дом в д. ћонтгомери. Ѕюджет: 30 млрд. вирт.
ѕри редактировании ViP транспорта:
 уплю а/м ViP класса "модификаци€ + название машины". Ѕюджет: свободный.
ѕродам а/м ViP класса "Turismo Cute Snowman". ÷ена: договорна€.]], "{FFFFFF}ѕрин€ть", "", 4)
    end)
sampRegisterChatCommand("gheto", function()
        sampShowDialog(1, "{FFF000}ѕравила войны за террриторию", [[
{FFD700}ќсновные правила:
{FFD700}1.1. {FFFFFF}Ќезнание правил не освобождает вас от ответственности;
{FFD700}1.2. {FFFFFF}ƒл€ войны за территорию требуетс€ 2 человека;
{FFD700}1.3. {FFFFFF}¬ойна за территорию начинаетс€ с 12:00 до 23:00 по ћ— ;
{FFD700}1.4. {FFFFFF}«а нарушение правил проведени€ войны за территорию, примен€ютс€ “юрьма, кик, warn, бан;
{FFD700}1.5. {FFFFFF}≈сли лидер бандитской группировки не отстоит свой срок - 14 дней, то его снимают предупреждением;
{FFD700}1.6. {FFFFFF}∆алобы на игроков отправл€ть в раздел "∆алобы на бандитов";
{FFD700}1.7. {FFFFFF}ƒействует 3 предупреждени€ во врем€ капта (0/3);
{FFD700}1.8. {FFFFFF}¬ойна за территорию ведЄтс€ по всему гетто, на главный район вражеских банд заходить запрещено;
{FFD700}1.9. {FFFFFF}«апрещено играть в гетто на "Android".

{228B22}2. –азрешено во врем€ проведени€ войны за территорию:
{228B22}2.1. {FFFFFF}–азрешено использовать оружи€, которые есть в /get guns;
{228B22}2.2. {FFFFFF}–азрешено использовать аптечки, наркотики;
{228B22}2.3. {FFFFFF}–азрешено использовать баги стрельбы;
{228B22}2.4. {FFFFFF}–азрешено убивать игрока, который создаЄт помеху на капте;
{228B22}2.5.{FFFFFF} –азрешено использовать пассажирское сиденье (только ћ4, и с присутствием водител€);
{228B22}2.6. {FFFFFF}–азрешено использовать крыши только в 1 прыжок, без помощи транспорта и других предметов.

{FF0000}3. «апрещено во врем€ проведени€ войны за территорию:
{FF0000}3.1.1. {FFFFFF}„иты.
Ќаказание: тюрьма на 180 минут, warn, -2 территории;
{FF0000}3.1.2. {FFFFFF}„иты на 6 ранге.
Ќаказание: тюрьма на 180 минут, warn, 1/3;
{FF0000}3.1.3. {FFFFFF}„иты на 7+ ранге.
Ќаказание: тюрьма на 180 минут, warn, -2 территории;
{FF0000}3.1.4. {FFFFFF}ќтказ от проверки на 6 ранге.
Ќаказание: тюрьма на 180 минут, warn, 1/3;
{FF0000}3.1.5. {FFFFFF}ќтказ от проверки на 7+ ранге.
Ќаказание: тюрьма на 180 минут, warn, -2 территории;
{FF0000}3.2. {FFFFFF}—бив анимки любым способом.
Ќаказание: тюрьма 60 минут и 1/3;
{FF0000}3.3. {FFFFFF}—кины другой банды.
Ќаказание: допуск к изменению скина администратором, 1/3;
{FF0000}3.4. {FFFFFF}Ќакрутка убийств в тюрьме (2 убийства).
Ќаказание: warn за ск, -1 территори€;
{FF0000}3.5. {FFFFFF}Spawn Kill. Ќаказание: warn, -1 территори€;
{FF0000}3.6. {FFFFFF}”частие на войне за территории с пингом 150+.
Ќаказание: кик;
{FF0000}3.7. {FFFFFF}Ѕыть на DM зоне с другими членами бандами и каптитьс€
Ќаказание: тюрьма 30 минут, 1/3;
{FF0000}3.8. {FFFFFF}¬ести свой "твинк" в других бандах и нарушать.
Ќаказание: BanIP, а так-же возвращение территорий;
{FF0000}3.9. {FFFFFF}”бивать игроков с танка/самолЄта/вертолЄта.
Ќаказание: тюрьма на 45 минут, 1/3;
{FF0000}3.10. {FFFFFF}«абиратьс€ на труднодоступную возвышенность.
Ќаказание: тюрьма на 25 минут, 1/3;
{FF0000}3.11. {FFFFFF}јнти килл (не дать убить себ€, чтобы не засчиталось убийство).
Ќаказание: тюрьма 30 минут, 1/3.
{FF0000}3.12. {FFFFFF}”ход от наказани€ (выйти с игры, когда нарушили правила).
Ќаказание: тюрьма на 30 минут, 1/3;
{FF0000}3.13. {FFFFFF}AFK больше 30 секунд.
Ќаказание: тюрьма 10 минут, 1/3;
{FF0000}3.14. {FFFFFF}ѕризывать игроков выйти с игры на некоторое врем€.
Ќаказание: мут инициатору на 60 минут, лидеру - выговор;
{FF0000}3.15. {FFFFFF}ѕомощь на капте от гражданских/членов другой бандитской группировки. Ќаказание: тюрьма на 30 минут;
{FF0000}3.16. {FFFFFF}Ѕаги: быстрый бег на колЄсико мышки, двойной прыжок на велосипеде.
»змена на др. клавишу, при игноре - warn;
{FF0000}3.17. {FFFFFF} апт обрезом/куском/респы.
Ќаказание: -2 территории. (-3, если 1 территори€ была захвачена - возвращаетс€);
{FF0000}3.18. {FFFFFF}ѕровоцировать вражеского члена банды на спавн килл.
Ќаказание: тюрьма на 25 минут, 1/3;
{FF0000}3.19. {FFFFFF}”вольнение на капте.
Ќаказание: игроку, который уволил - увольн€етс€, лидер - выговор, 1/3;
{FF0000}3.20. {FFFFFF}Ќе€вка.
{FFFFFF}Ќаказание:3 (7) минуты - 1/3, 6 (3) минуты - 2/3, конец капта (0:01) - терра выдаЄтс€, котора€ ожидала неактив
{FF0000}3.21. {FFFFFF}—лив территорий во врем€ голды. Ќаказание: сн€тие обоих лидеров, „— √етто.

{FFA500}4. ѕравила парковки дома на колЄсах:
{FFA500}4.1. {FFFFFF}«апрещено ставить ƒЌ  у квадрата (ƒЌ  должен находитс€ от 2ух кв от терры).
{FFFFFF}Ќаказание: 1 раз - предупреждение о перепарковке, игнор - тюрьма на 15 минут, 1/3;
{FFA500}4.2. {FFFFFF}—тавить ƒЌ  в квадрате, в котором ведЄтс€ война.
Ќаказание: тюрьма 15 минут, 1/3;
{FFA500}4.3. {FFFFFF}ƒвигать вражеский ƒЌ  ближе к мигающему квадрату.
Ќаказание: тюрьма на 15 минут, 1/3.

{B22222}5. Ћишение территорий:
{B22222}5.1. {FFFFFF}„иты.
Ќаказание: -2 территории;
{B22222}5.1.1. {FFFFFF}„иты на 6 ранге.
Ќаказание: тюрьма на 180 минут, warn, 1/3;
{B22222}5.1.2. {FFFFFF}„иты на 7+ ранге.
Ќаказание: тюрьма на 180 минут, warn, -2 территории;
{B22222}5.2. {FFFFFF}«а использование сбива анимации.
Ќаказание: jail 60 min , 1/3;
{B22222}5.3. {FFFFFF}«а накрутку убийств в тюрьме (2 убийства).
Ќаказание: -1 территори€;
{B22222}5.4. {FFFFFF}«а массовое ск: убивать в чужом доме, личном доме.
Ќаказание: -3 территори€;
{B22222}5.5. {FFFFFF}«а капт обрезом/куском/респы.
Ќаказание: -4 территории. (-5, если территори€ была захвачена - возвращаетс€);
{B22222}5.6. {FFFFFF}«а не€вку на территорию.
Ќаказание: 3 минуты - 1/3, 6 минуты - 2/3, конец капта - территори€
выдаЄтс€ банде, котора€ ожидала 2-ую банду;
{B22222}5.7. {FFFFFF}ќтказ от проверки.
Ќаказание: -2 территории;

{00FFFF}6. ћороз:
{00FFFF}6.1. {FFFFFF}Ћидер банды имеет право вз€ть мороз 2 раза (2 раз может через неделю прошлого мороза);
{00FFFF}6.2. {FFFFFF}Ћидер банды может вз€ть мороз на 6 часов;
{00FFFF}6.3. {FFFFFF}Ћидер банды при постановлении может отказатьс€ от мороза, но может его вз€ть тогда, когда ему он потребуетс€;
{00FFFF}6.4. {FFFFFF}Ќа вз€тие мороза должна быть уважительна€ причина (нет состава - не учитываетс€).
]], "{FFFFFF}ѕрин€ть", "", 4)
    end)
sampRegisterChatCommand("html", function()
        sampShowDialog(5, "{FFF000}HTML-цвета", [[
 {FFFFFF} расные цвета:
{CD5C5C} Test Ч {FFFFFF}CD5C5C
{F08080} Test - {FFFFFF}F08080
{FA8072} Test - {FFFFFF}FA8072
{E9967A} Test - {FFFFFF}E9967A
{FFA07A} Test - {FFFFFF}FFA07A
{DC143C} Test - {FFFFFF}DC143C
{FF0000} Test - {FFFFFF}FF0000
{B22222} Test - {FFFFFF}B22222
{8B0000} Test - {FFFFFF}8B0000

 –озовые цвета:
{FFC0CB} Test - {FFFFFF}FFC0CB
{FFB6C1} Test - {FFFFFF}FFB6C1
{FF69B4} Test - {FFFFFF}FF69B4
{FF1493} Test - {FFFFFF}FF1493
{C71585} Test - {FFFFFF}C71585
{DB7093} Test - {FFFFFF}DB7093

 ќранжевые цвета:
{FFA07A} Test - {FFFFFF}FFA07A
{FF7F50} Test - {FFFFFF}FF7F50
{FF6347} Test - {FFFFFF}FF6347
{FF4500} Test - {FFFFFF}FF4500
{FF8C00} Test - {FFFFFF}FF8C00
{FFA500} Test - {FFFFFF}FFA500

 ∆Єлтые цвета:
{FFD700} Test - {FFFFFF}FFD700
{FFFF00} Test - {FFFFFF}FFFF00
{FFFFE0} Test - {FFFFFF}FFFFE0
{FFFACD} Test - {FFFFFF}FFFACD
{FAFAD2} Test - {FFFFFF}FAFAD2
{FFEFD5} Test - {FFFFFF}FFEFD5
{FFE4B5} Test - {FFFFFF}FFE4B5
{FFDAB9} Test - {FFFFFF}FFDAB9
{EEE8AA} Test - {FFFFFF}EEE8AA
{F0E68C} Test - {FFFFFF}F0E68C
{BDB76B} Test - {FFFFFF}BDB76B

 ‘иолетовые цвета:
{E6E6FA} Test - {FFFFFF}E6E6FA
{D8BFD8} Test - {FFFFFF}D8BFD8
{DDA0DD} Test - {FFFFFF}DDA0DD
{EE82EE} Test - {FFFFFF}EE82EE
{DA70D6} Test - {FFFFFF}DA70D6
{FF00FF} Test - {FFFFFF}FF00FF
{BA55D3} Test - {FFFFFF}BA55D3
{9370DB} Test - {FFFFFF}9370DB
{8A2BE2} Test - {FFFFFF}8A2BE2
{9400D3} Test - {FFFFFF}9400D3
{9932CC} Test - {FFFFFF}9932CC
{8B008B} Test - {FFFFFF}8B008B
{800080} Test - {FFFFFF}800080
{4B0082} Test - {FFFFFF}4B0082
{6A5ACD} Test - {FFFFFF}6A5ACD
{483D8B} Test - {FFFFFF}483D8B

  оричневые цвета:
{FFF8DC} Test - {FFFFFF}FFF8DC
{FFEBCD} Test - {FFFFFF}FFEBCD
{FFE4C4} Test - {FFFFFF}FFE4C4
{FFDEAD} Test - {FFFFFF}FFDEAD
{F5DEB3} Test - {FFFFFF}F5DEB3
{DEB887} Test - {FFFFFF}DEB887
{D2B48C} Test - {FFFFFF}D2B48C
{BC8F8F} Test - {FFFFFF}BC8F8F
{F4A460} Test - {FFFFFF}F4A460
{DAA520} Test - {FFFFFF}DAA520
{DAA520} Test - {FFFFFF}DAA520
{B8860B} Test - {FFFFFF}B8860B
{CD853F} Test - {FFFFFF}CD853F
{D2691E} Test - {FFFFFF}D2691E
{8B4513} Test - {FFFFFF}8B4513
{8B4513} Test - {FFFFFF}8B4513
{A0522D} Test - {FFFFFF}A0522D
{A52A2A} Test - {FFFFFF}A52A2A
{800000} Test - {FFFFFF}800000

 «елЄные цвета:
{ADFF2F} Test - {FFFFFF}ADFF2F
{7FFF00} Test - {FFFFFF}7FFF00
{7CFC00} Test - {FFFFFF}7CFC00
{00FF00} Test - {FFFFFF}00FF00
{32CD32} Test - {FFFFFF}32CD32
{98FB98} Test - {FFFFFF}98FB98
{90EE90} Test - {FFFFFF}90EE90
{00FA9A} Test - {FFFFFF}00FA9A
{3CB371} Test - {FFFFFF}3CB371
{2E8B57} Test - {FFFFFF}2E8B57
{228B22} Test - {FFFFFF}228B22
{008000} Test - {FFFFFF}008000
{006400} Test - {FFFFFF}006400
{9ACD32} Test - {FFFFFF}9ACD32
{6B8E23} Test - {FFFFFF}6B8E23
{808000} Test - {FFFFFF}808000
{556B2F} Test - {FFFFFF}556B2F
{66CDAA} Test - {FFFFFF}66CDAA
{8FBC8F} Test - {FFFFFF}8FBC8F
{20B2AA} Test - {FFFFFF}20B2AA
{008B8B} Test - {FFFFFF}008B8B
{008080} Test - {FFFFFF}008080

 —иние цвета:
{00FFFF} Test - {FFFFFF}00FFFF
{E0FFFF} Test - {FFFFFF}E0FFFF
{AFEEEE} Test - {FFFFFF}AFEEEE
{7FFFD4} Test - {FFFFFF}7FFFD4
{40E0D0} Test - {FFFFFF}40E0D0
{48D1CC} Test - {FFFFFF}48D1CC
{00CED1} Test - {FFFFFF}00CED1
{5F9EA0} Test - {FFFFFF}5F9EA0
{4682B4} Test - {FFFFFF}4682B4
{B0C4DE} Test - {FFFFFF}B0C4DE
{B0E0E6} Test - {FFFFFF}B0E0E6
{ADD8E6} Test - {FFFFFF}ADD8E6
{87CEEB} Test - {FFFFFF}87CEEB
{87CEFA} Test - {FFFFFF}87CEFA
{00BFFF} Test - {FFFFFF}00BFFF
{1E90FF} Test - {FFFFFF}1E90FF
{6495ED} Test - {FFFFFF}6495ED
{7B68EE} Test - {FFFFFF}7B68EE
{4169E1} Test - {FFFFFF}4169E1
{0000FF} Test - {FFFFFF}0000FF
{0000CD} Test - {FFFFFF}0000CD
{00008B} Test - {FFFFFF}00008B
{000080} Test - {FFFFFF}000080
{191970} Test - {FFFFFF}191970

 Ѕелые цвета:
{FFFFFF} Test - {FFFFFF}FFFFFF
{FFFAFA} Test - {FFFFFF}FFFAFA
{F0FFF0} Test - {FFFFFF}F0FFF0
{F5FFFA} Test - {FFFFFF}F5FFFA
{F0FFFF} Test - {FFFFFF}F0FFFF
{F0F8FF} Test - {FFFFFF}F0F8FF
{F8F8FF} Test - {FFFFFF}F8F8FF
{F5F5F5} Test - {FFFFFF}F5F5F5
{F5F5DC} Test - {FFFFFF}F5F5DC
{FDF5E6} Test - {FFFFFF}FDF5E6
{FFFAF0} Test - {FFFFFF}FFFAF0
{FFFFF0} Test - {FFFFFF}FFFFF0
{FAEBD7} Test - {FFFFFF}FAEBD7
{FAF0E6} Test - {FFFFFF}FAF0E6
{FFF0F5} Test - {FFFFFF}FFF0F5
{FFE4E1} Test - {FFFFFF}FFE4E1

 —ерые цвета:
{DCDCDC} Test - {FFFFFF}DCDCDC
{D3D3D3} Test - {FFFFFF}D3D3D3
{C0C0C0} Test - {FFFFFF}C0C0C0
{A9A9A9} Test - {FFFFFF}A9A9A9
{808080} Test - {FFFFFF}808080
{696969} Test - {FFFFFF}696969
{778899} Test - {FFFFFF}778899
{708090} Test - {FFFFFF}708090
{2F4F4F} Test - {FFFFFF}2F4F4F

]], "{FFFFFF}ѕрин€ть", "", 5)
    end)
sampRegisterChatCommand("emc", function()
        sampShowDialog(5, " ", [[
{FFFFFF}”лучшение: {9ACD32}PREMIUM HELPER
{FFFFFF}—тоимость: {9ACD32}1 российский рубль
ѕокупка только у {9acd32}vk.com/obikenobii


{FF6347}ѕреимущества PREMIUM статуса
{FFFFFF}1)PREMIUM статус не нужно продлевать ( {c1cc2b}Ќеограниченный срок действи€ {FFFFFF})
{FFFFFF}2)¬ы получаете уважение от ѕомощника «ам. основател€
3)¬ам выдаЄтс€ роль в Discord сервере Luxwen Role Play: {FF0000} орусантский √вардеец
{FFFFFF}4)¬ы сможете предлагать свои предложени€ по улучшению ответов и другого!
{FFFFFF}5)¬ќ«ћќ∆Ќќ—“№ Ѕџ—“–ќ Ќј‘ј–ћ»“№ –≈ѕќ–“џ » ѕќЋ”„»“№ ‘ƒ4! (подробнее: /howfd)
]], "{FFFFFF}ѕрин€ть", "ќтмена", 0)
    end)
sampRegisterChatCommand("howfd", function()
        sampShowDialog(5, " ", [[
{FFFFFF}„тобы получить бесплатно Full Dostup 4 уровн€ *({FF0000}ћенеджер{FFFFFF}), необходимо:
{ee7c00}Х {FFFFFF}ќтветить на 10000 репортов.
{ee7c00}Х {FFFFFF}«аблокировать 2000 игроков.
{ee7c00}Х {FFFFFF}ѕосадить в тюрьму 2000 игроков.
{ee7c00}Х {FFFFFF}¬ыдать блокировку чата 1500 игрокам.
]], "{FFFFFF}ѕрин€ть", "ќтмена", 0)
    end)
    for k, v in pairs(pm) do
        sampRegisterChatCommand(""..k, function(id)
            if tonumber(id) ~= nil then
                if sampIsPlayerConnected(tonumber(id)) then
                    sampSendChat("/pm "..id.." "..v)
                else
                    sampAddChatMessage("{FF6347}[ќшибка] {FFFFFF}¬ы указали свой ID/игрок offline!", -1)
                end
            else
                sampAddChatMessage("{FF6347}[ќшибка] {FFFFFF}¬ведите: {FFFFFF}/"..k.." [ID].", -1)
            end
        end)
    end
    wait(-1)
end
