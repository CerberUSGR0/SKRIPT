require 'lib.moonloader'


equire "lib.moonloader" -- ����������� ����������
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local keys = require "vkeys"
local imgui = require 'imgui'
local tag = "{0000ff}[Sobes Helper by SArMAT]: {ffffff}"
update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/CerberUSGR0/SKRIPT/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://github.com/thechampguess/scripts/blob/master/autoupdate_lesson_16.luac?raw=true" -- ��� ���� ������
local script_path = thisScript().path

local pm = {
    ['sle'] = '��������� �����! ������� �������� �� ����� ������.',
    ['sln'] = '��������� �����! �����, �� �������� �� ���������� � �������.',
    ['slo'] = '��������� �����! �����, �� �������� �� ���������� � �� ��������.',
    ['hel'] = '��������� �����! ������ �������� ��� ������.',
    ['jb'] = '��������� �����, ������ ������ �� ����� � gta-luxwen.ru.',
    ['offt'] = '��������� �����, ����������, �� ���������.',
    ['fs'] = '��� ����� � gta-luxwen.ru, ���� � gta-lux.ru, ������ ���������: vk.com/luxwen_rp.',
    ['vks'] = '��������� ���������� � vk.com/cavallaro13, �������� �������������� � vk.com/obikenobii.',
    ['don'] = '����� ���������� ����������, ������� /donaterub (�� �����), /donate (�� ������� �����).',
    ['badm'] = '����� ����� ���������������, ������� /buyadm ��� �������� ���� ������.',
    ['blead'] = '����� ����� �������, ������� ��������� �� ����� (gta-luxwen.ru).',
    ['bhelp'] = '����� ����� ������� ���������, ������� /buyhelp, ��� �� ������� ��������� �� �����.',
    ['bfull'] = '����� ���������� ������ ������ (FD), ������� /buyfull.',
    ['prom'] = '����� �������� ���������, ����������� �� �������� � ������ �� � vk.com/luxwen_rp.',
    ['wi'] = '��������� �����, ��������.',
    ['otk'] = '��������� �����, ��������.',
    ['kupi'] = '����� ��������� ������� ����, ��������� �� ��� ���� � gta-lux.ru.',
    ['cmd'] = '����������� ������� ������� ����� � � /mm � 2. ������� ������� �.',
    ['lux'] = 'Luxwen-������ ��� ������,�� ������� �� ������ ������� ��������� (/gps � 13.����������).',
    ['tex'] = '���������� � ����������� ������ �� ������ � gta-luxwen.ru',
    ['fst'] = '����� ���: ���� � /box, ����-�� � /kongfu, ������� � /kickbox',
    ['giv'] = '/invite - �������, /uninvite - �������, /giverank - ��������/�������� ����.',
    ['ds'] = '��� Discord ������ � discord.gg/yrzYjNTyGC.',
    ['lea'] = '��������� �����, ������� � /leave �, ����� �������� �����������.',
    ['accs'] = '������ ���������� � ������, ������� � ����������, ��� � �������� �����������.',
    ['res'] = '��������� �����, ������� � /reset �, ����� ����� ��� ����������.',
    ['rubl'] = '����� �������� �����, ���������� � ������������, ��������� ��������� � ��������.',
    ['aut'] = '��������� �����, ����� ����� ���������, �������: /gps - 2. ����������.',
    ['pasl'] = '�������: /pass, ��������: /lic, ���. �����: /showmedcard, ���. ������� �/�: /carpass.',
    ['dnk'] = '������ ��� �� ������: � /gps - 18. ������� ��������� (��� �� ������) �.',
    ['sdnk'] = '����� ������� ��� �� ������, ������� � /sellkhouse �.',
    ['he'] = '��������� �����, ������������ ������� � ����� ���������',
    ['add'] = '��������� �����, �������: � /ad � ������� ����������, /vad � VIP ���������� �.',
    ['dm'] = '��������� �����, ����� ������� � � DM-���� � , ��������� � ���� ������ ����� ������.',
    ['dmm'] = '��������� �����, ����� �������� � DM-���� � � /exitdm.',
    ['natd'] = 'NATD � ��� ������������ �������������������� �����������.',
    ['natdf'] = 'NATD ���������� ������� �����-������� ������������ � �����.',
    ['gss'] = '������� �������� �� ����� � Pablo Parlament (vk.com/tom_torres).',
    ['gsm'] = '������� �������� �� ������� � Gorge Winston (https://vk.com/radmirtop01).',
    ['gsg'] = '������� �������� �� ���. ����������� � Leon Scaletta (vk.com/me.litovsky).',
    ['kurn'] = '������� ��������� � Blayze Noufam (vk.com/ugenrl).',
    ['kurg'] = '������� ���. �������� � �� ��������.',
    ['alg'] = '����� ����� � ����/����� � �����, ����������� ALT.',
    ['gug'] = '����� ����� ������, ����������� � /get guns � �� ������ �����.',
    ['gum'] = '����� ����� ������, ����������� � /getweapon � � ������ ������ ����� ������.',
    ['cpt'] = '����� ������ ����� �� ����������, ������� � � /capture �.',
    ['vip'] = '������� /viphelp, ����� ���������� ������� � VIP-������ �.',
    ['lsgu'] = '������� � �����, ��������� �������, � ��� ������ ����� ����� � �������.',
    ['hcmd'] = '������� /hhelp, ����� ������ ������� �������� ���������.',
    ['ut'] = '��������� �����, �������� ���� ���������.',
    ['sus'] = '������� ������ ������� � /su (�������� � 8 ����� � PD � � 1 ����� � FBI).',
    ['geta'] = '��������� �����, ����� �������� �����-�����, ������� /getadm.',
    ['luxc'] = '������ ��������� ������� � ������, � ������� �� ������ ��������� ������ � �����.',
    ['luxcc'] = '���������� ����� �� ����� �. ���-��������, �� ��� �� ��������� Luxwen-Coins.',
    ['coin'] = '��������� ��������� �������, ����� �������� Luxwen-Coins. �������: /coins.',
    ['vipc'] = 'ViP ���� ����� ��������: � /donaterub, � �����������, ����������� �� ���-���.',
    ['da'] = '��������� �����, ��.',
    ['net'] = '��������� �����, ���.',
    ['per'] = '��������� �����, ���� ��������� �������� ��������������!',
    ['xdon'] = '��������� �����, ���������� � X2 ����� � �������� ������!',
    ['cha'] = '��������� �����, ����� �������� � �������� ���, ������� F6 .',
    ['fam'] = '��������� �����, ������� ����� � � /donaterub - ������� ����� �.',
    ['hit'] = '��������� �����, ������� � �������� ������� ������� � F �.',
    ['dvig'] = '��������� �����, ����� ������� ���������, ������� � 2 � ���� ��������: � /en �.',
    ['vcar'] = '��������� �����, ������� /cars, ����� ���������� ���� ������.',
    ['meta'] = '��������� �����, ����������� /gps - 16, ����� ���������� �� ������.',
    ['tiee'] = '��������� �����, ������� /tie, ����� ������� ������.',
    ['selv'] = '��������� �����, /sellvipauto id [1-������] [2-�����] [3-�����] [4-coins] �����.',
    ['inve'] = '��������� �����, ������� � Y � ��� ������� /inv, ����� ������� ���������.',
    ['fixc'] = '��������� �����, ������� /fixcar - ������� �/�, /cars - ViP ���������� �/�.',
    ['inf'] = '��������� �����, �� ������� ������ �����������. �������� ����.',
    ['nikak'] = '��������� �����, �����. �������� ����.',
    ['ras'] = '��������� �����, ����������� �� �������� � ��. ������ ��������� (vk.com/luxwen_rp).',
    ['bi'] = '��������� �����, ������� /buybiz, ����� ������ ������.',
    ['hom'] = '��������� �����, �c������ �� ������ ������� ����, � ����� ������� � ������ �.',
    ['chan'] = '��������� �����, ����� ������� ���� �� �������, ������� /changeskin (�����������/�����).',
    ['repp'] = '��������� �����, ������ ��� ��������� � ������. �������� ����.',
    ['spies'] = '��������� �����, ����� ������ ����������, ������� � /spy �.',
    ['rp'] = '��������� �����, ����������� ����. �������� ����.',
    ['nos'] = '��������� �����, � �������� ������ ������ ����. ������ � ��. �������� ����.',
    ['qq'] = '������������ ���, ��������� �����.',
    ['gg'] = '������������� Luxwen Role Play ������ ��� �������� ����, �������, ��� �� � ���� :).',
    ['par'] = '��������� �����, ������������: /park - ������� ���������, /vpark - ViP ���������.',
    ['mas'] = '��������� �����, ����� �����/������ �����, �������������� ��������� (������� Y).',
    ['sbiz'] = '��������� �����, ����� ������� ������, ������� /sellbiz.',
    ['shom'] = '��������� �����, ����� ������� ���, ������� /sellhouse.',
    ['gp'] = '��������� �����, �������������� GPS-�����������: /gps.',
    ['bb'] = '�� �������� � ����������? ������ ������ �� ����� � gta-luxwen.ru.',
    ['acmd'] = '�������������, ������� /ahelp, ����� ���������� ������� ��������������!',
    ['adm'] = '��������� �����, ��� ��������� ��������������, �������: /admins (� Silver ViP).',
    ['lead'] = '��������� �����, ��� ��������� �������, �������: /leaders.',
    ['hea'] = '��������� �����, ��� ��������� ��������, �������: /helpers.',
    ['rr'] = '��������� �����, ����������� �� ������.',
    ['dan'] = '��������� �����, ����� ��� ����. �������� ����.',
    ['an'] = '��������� ������, ����� �������� �� ���������, ������� � /ans �.',
    ['vr'] = '��������� �����, ����� �������� � � ViP � ����, ������� /vc.',
    ['aa'] = '��������� �������������, ������ � /a.',
    ['stp'] = '��������� �����, ����� �������� � ����� ������ �, ������� /setspawn.',
    ['hc'] = '��������� ������, ����� �������� � ���� ��������, ������� /c.',
    ['ps'] = '��������� �����, �� �������. �������� ����.',
    ['lok'] = '��������� �����, ����������� � /lock �. �������� ����.',
    ['sbo'] = '��������� �����, �� ������� �������� �������. ��������. �������� ����.',
    ['ing'] = '��������� �����, �� ��������� � �� �������� �� �������. ����������� � ����/������.',
    ['chk'] = '��������� �����, ����� ����������� ������ ��������� ������ ������, ������� /buylead.',
    ['dru'] = '��������� �����, ����� ������������ ���������, ������� /usedrugs.',
    ['hou'] = '��������� �����, ����� ����� ���� ���, ����������� /home.',
    ['invi'] = '����� �������� �� �������, �������� ������������� / �������� ����� auto-invite �� ������.',
    ['pri'] = '��������� �����, ����� ������� ���� � ����������, ������� /priz.',
    ['sobes'] = '��������� �����, �������� � ������/���� ����� ���������� �������������.',
    ['iiban'] = 'Ҹ���� ������� �� ����� �������, �� �� �� ������� ����� ������.',
}
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(8000) end
    sampAddChatMessage("*({FF0000}���. ����������{FFFFFF}) Kenobi[66]: �����-�������� ������� �������, �������������!", 0xFFFFFF)
    sampAddChatMessage("*({FF0000}���. ����������{FFFFFF}) Kenobi[66]: 04.03.2022 ��������� � {c0c0c0}�����-��������� {fFFFFF}� ������������.", 0xFFFFFF)
    sampAddChatMessage("*({FF0000}���. ����������{FFFFFF}) Kenobi[66]: �����: Kenobi | Vladik_Wakefield.", 0xFFFFFF)
    while not isSampAvailable() do wait(8000) end

    sampRegisterChatCommand("update", cmd_update)


    	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
        nick = sampGetPlayerNickname(id)

        downloadUrlToFile(update_url, update_path, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                updateIni = inicfg.load(nil, update_path)
                if tonumber(updateIni.info.vers) > script_vers then
                    sampAddChatMessage("���� ����������! ������: " .. updateIni.info.vers_text, -1)
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
                        sampAddChatMessage("������ ������� ��������!", -1)
                        thisScript():reload()
                    end
                end)
                break
            end

    	end
    end

    sampRegisterChatCommand("apm", function()
        sampShowDialog(1, "{228b22}�������, ��������� ���:", [[
{FFFFFF}1) {3CB371}/sle � {ffffff}�������� ������, ��� �� {FC4347}������� {FFFFFF}�� {FFD700}�������.
{FFFFFF}2) {3CB371}/sln � {ffffff}�������� ������, ��� {FC4347}���������� {FFFFFF}��� {FFD700}�������.
{FFFFFF}3) {3CB371}/slo � {ffffff}�������� ������, ��� {FC4347}��������� {FFD700}�� ����������.
{FFFFFF}4) {3CB371}/hel � {ffffff}����������� {98FB98}������ {FFFFFF}������.
{FFFFFF}5) {3CB371}/jb � {ffffff}�������� ������, ����� ������� {FC4347}������ �� �����.
{FFFFFF}6) {3CB371}/offt � {ffffff}�������� ������, ����� {FC4347}�� ��������.
{FFFFFF}7) {3CB371}/otk � {FF0000}�������� {FFFFFF}������.
{FFFFFF}8) {008080}/da � {FFFFFF}�������� ������ � {00FF00}�� {FFFFFF}�.
{FFFFFF}9) {008080}/net � {FFFFFF}�������� ������ � {b22222}��� {FFFFFF}�.
{FFFFFF}10) {FFDAB9}/nikak � {FFFFFF}�������� ������, � ����� �.
{FFFFFF}11) {32cd32}/qq � {FFFFFF}���������������� ������.
{FFFFFF}12) {F0E68C}/hom � {FFFFFF}������ ������, ��� ������ ���.
{FFFFFF}13) {F0E68C}/biz � {FFFFFF}�������� ������, ��� ������ ������.
{FFFFFF}14) {CD853F}/repp � {FFFFFF}�������� ������, ����� ����� � ������.
{FFFFFF}15) {3CB371}/ut � {FFFFFF}�������� ������, ����� {FFFF00}������� {FFFFFF}��� {00BFFF}���������.
{FFFFFF}16) {3CB371}/wi � {ffffff}�������� ������, ����� {FFFF00}������.
{FFFFFF}17) {FFD700}/gsm � {FFFFFF}�������� ������, ��� {A0522D}������� �������� �� �������.
{FFFFFF}18) {FFD700}/gsg � {FFFFFF}�������� ������, ��� {4169E1}������� �������� �� ���. �����������.
{FFFFFF}19) {FFD700}/gss � {FFFFFF}�������� ������, ��� {228B22}������� �������� �� �����.
{FFFFFF}20) {FFD700}/kurn � {FFFFFF}�������� ������, ��� {8B0000}������� ���������.
{FFFFFF}21) {FFD700}/kurg � {FFFFFF}�������� ������, ��� {4169E1}������� ���. ��������.
{FFFFFF}22) {FFD700}/vks � {FFFFFF}�������� ������, ��� {2681ff}������� ������������� {FFFFFF}� {FF0000}���������� �������.
{FFFFFF}23) {ADFF2F}/buyfull � {FFFFFF}�������� ������, ��� �������� {FF6347}Full Dostup.
{FFFFFF}24) {ADFF2F}/badm � {ffffff}�������� ������, ��� �������� {FFD700}���� ��������������.
{FFFFFF}25) {ADFF2F}/blead � {ffffff}�������� ������, ��� �������� {FFD700}���� ������.
{FFFFFF}26) {ADFF2F}/bhelp � {ffffff}�������� ������, ��� �������� {FFD700}���� ������ ���������.
{FFFFFF}27) {ADFF2F}/promo � {ffffff}�������� �� {FFD700}���������.
{FFFFFF}28) {ADFF2F}/kupi � {FFFFFF}�������� ������, ��� {FFD700}��������� ����.
{FFFFFF}29) {ADFF2F}/don � {FFFFFF}�������� ������, ��� ������� {FFD700}�����.
{FFFFFF}30) {DAA520}/tex � {FFFFFF}�������� ������ ���������� � {F4A460}����������� ������ {FFFFFF}�� ������.
{FFFFFF}31) {DAA520}/ds � {FFFFFF}������� ������ �� {6495ED}Discord ������.
{FFFFFF}32) {DAA520}/dnk � {ffffff}�������� ������, ��� ������ {9ACD32}��� �� ������ {FFFFFF}({9ACD32}���{FFFFFF}).
{FFFFFF}33) {DAA520}/sdnk � {FFFFFF}�������� ������, ��� ������ {9ACD32}��� �� ������ {FFFFFF}({9ACD32}���{FFFFFF}).
{FFFFFF}34) {9370DB}/cmd � {FFFFFF}�������� ��� {9370DB}������� �������.
{FFFFFF}35) {9370DB}/fst � {FFFFFF}�������� ������ ��� {9370DB}����� ���.
{FFFFFF}36) {9370DB}/giv � {FFFFFF}�������� ������ ��� ����������� {FF6347}������ {FFFFFF}� {FF6347}�����������.
{FFFFFF}37) {9370DB}/lea � {FFFFFF}�������� ������, ��� {9370DB}���������.
{FFFFFF}38) {9370DB}/accs � {FFFFFF}�������� ������, ��� {32cd32}������ {9370DB}����������.
{FFFFFF}39) {9370DB}/res � {FFFFFF}�������� ������, ��� {FF4500}����� ��� {9370DB}����������.
{FFFFFF}40) {D8BFD8}/rubl � {FFFFFF}�������� ������, ��� �������� {D8BFD8}�����.
{FFFFFF}41) {9370DB}/aut � {FFFFFF}�������� ������, ��� ��������� {DB7093}���������.
{FFFFFF}42) {9370DB}/pasl � {FFFFFF}�������� ������, ��� �������� {32cd32}��� {FFFFFF}���� {D2691E}���������.
{FFFFFF}43) {FFFF00}/lux � {FFFFFF}�������� ������, ��� ����� {FFFF00}Luxwen ������.
{FFFFFF}44) {008000}/he � {FFFFFF}�������� ������, ��� ������������ {4682B4}�������.
{FFFFFF}45) {008000}/adv � {FFFFFF}�������� ������, ��� ��������� {00FF00}����������.
{FFFFFF}46) {FF6347}/dm � {FFFFFF}�������� ������, ��� {008000}����� {FFFFFF} � {FF7F50}DM-����.
{FFFFFF}47) {FF6347}/dmm � {FFFFFF}�������� ������, ��� {FF4500}����� {FFFFFF}� {FF7F50}DM-����.
{FFFFFF}48) {FF8C00}/alg � {FFFFFF}�������� ������, ��� ����� � ����/����� � �����.
{FFFFFF}49) {FF8C00}/gug � {FFFFFF}�������� ������, ��� ����� ������ � {9ACD32}�����.
{FFFFFF}50) {FF8C00}/gum � {FFFFFF}�������� ������, ��� ����� ������ � {8B0000}�����.
{FFFFFF}51) {FF8C00}/lsgu � {FFFFFF}�������� ������, ��� ����� ������ � {4169E1}LSPD.
{FFFFFF}52) {DB7093}/vip � {FFFFFF}�������� ������, ����� ������� ���� � {FFD700}VIP.
{FFFFFF}53) {DB7093}/cpt � {FFFFFF}�������� ������, ��� ������ {FF6347}����� �� ����������.
{FFFFFF}54) {DB7093}/tiee � {FFFFFF}�������� ������, ��� {20B2AA}������� {FFFFFF}������.
{FFFFFF}55) {E9967A}/hcmd � {FFFFFF}�������� ������, ��� {32cd32}���������� ������� {FFFF00}�������.
{FFFFFF}56) {A52A2A}/sus - {FFFFFF}�������� ������, ��� ������ {4169E1}������ {FFFFFF}������.
{FFFFFF}57) {FFFF00}/luxc � {FFFFFF}�������� ������, ��� ������������ �� ���� ������ {66CDAA}���������� �������.
{FFFFFF}58) {FFFF00}/luxcc � {FFFFFF}�������� ������, ��� ������������ �� ���� ������ {66CDAA}��������� �������.
{FFFFFF}59) {A9A9A9}/meta � {FFFFFF}�������� ������, ��� ���������� {FFFFFF}�� ������ {66CDAA}�������� �������.
{FFFFFF}60) {FFFF00}/coin � {FFFFFF}�������� ������, ��� ����� {FFA500}Luxwen-Coins.
{FFFFFF}61) {DC143C}/vipc � {FFFFFF}�������� ������, ��� ����� {FF00FF}ViP ���������.
{FFFFFF}62) {A9A9A9}/sellv � {FFFFFF}�������� ������, ��� ������� {FF00FF}ViP ���������.
{FFFFFF}63) {a9a9a9}/fixc � {FFFFFF}�������� ������, ��� ���������� ������.
{FFFFFF}64) {Dc143C}/per � {FFFFFF}�������� {FFD700}��������� {FFFFFF}������� ��������������.
{FFFFFF}65) {6A5ACD}/cha � {FFFFFF}�������� ������, ��� �������� � {AFEEEE}�������� ���.
{FFFFFF}66) {FFD700}/xdon � {FFFFFF}�������� ������, ��� {FF4500}X2 �����. {FFFFFF}�������� ������.
{FFFFFF}67) {3CB371}/fam � {FFFFFF}�������� ������, ��� {32cd32}������� �����.
{FFFFFF}68) {00FF7F}/dvig � {FFFFFF}�������� ������, ��� {7FFFD4}������� ���������.
{FFFFFF}69) {A9A9A9}/hit � {FFFFFF}�������� ������, ��� {6495ED}������� ����� {FFFFFF}� ��������.
{FFFFFF}70) {FFDAB9}/inve � {FFFFFF}�������� ������, ����� �������������� {FFFF00}���������.
{FFFFFF}71) {FF0000}/inf � {FFFFFF}�������� ������, ��� �� �� �������� ������ ������ �����������.
{FFFFFF}72) {FFDAB9}/ras � {FFFFFF}�������� ������, ��� ����� ������� ������� � ��������.
{FFFFFF}73) {008000}/nos � {FFFFFF}�������� ������, ��� � �������� ������ {228b22}������ {98FB98}����.
{FFFFFF}74) {CD853F}/rp � {FFFFFF}�������� ������, ����� {DAA520}��������� {FFFFFF}���.
{FFFFFF}75) {FFF000}/spies � {FFFFFF}�������� ������, ��� ������ ���������� � ���/��������.
{FFFFFF}76) {FFC500}/chan � {FFFFFF}�������� ������, ��� �������� {9370DB}���� �� {FFA07A}�������.
{FFFFFF}77) {c0c0c0}/gar � {FFFFFF}�������� ������, ��� ��� {DDA0DD}������ ��������� � {FFF000}������ ����.
{FFFFFF}78) {A0522D}/gg � {FFFFFF}�������� ������ {6495ED}�������� {FFFFFF}����.
{FFFFFF}79) {DC143C}/shom � {FFFFFF}�������� ������, ��� ������� ���.
{FFFFFF}80) {DC143C}/sbiz � {FFFFFF}�������� ������, ��� ������� ������.
{FFFFFF}81) {DC143C}/par � {FFFFFF}�������� ������, ��� {CD5C5C}������������ ���� ���������.
{FFFFFF}82) {DC143C}/mas � {FFFFFF}�������� ������, ��� {FF0000}�����/{228B22}������ �����.
{FFFFFF}83) {DC143C}/gp � {FFFFFF}�������� ������, ����� �������������� ����������� (GPS).
{FFFFFF} 84) {00FF00}/lead � {FFFFFF}�������� ������, ��� ������� ������ {228b22}�������.
{FFFFFF} 85) {00FF00}/adm � {FFFFFF}�������� ������, ��� ������� ������ {FF0000}�������������.
{FFFFFF} 86) {00FF00}/hea � {FFFFFF}�������� ������, ��� ������� ������ {ffd700}��������.
{FFFFFF} 87) {6B8E23}/acmd � {FFFFFF}�������� ��������������, ��� ������� {98FB98}������� ��������������.
{FFFFFF} 88) {87CEFA}/aa � {FFFFFF}�������� ��������������, ����� ����� � {7CFC00}�����. {FFFFFF}���.
{FFFFFF} 89) {CD853F}/rr � {FFFFFF}�������� ������, ����� {F0E68C}��������� {FFFFFF}�� ������.
{FFFFFF} 90) {BC8F8F}/dan � {FFFFFF}�������� ������, ��� �� ��� {1E90FF}��������� {FFFFFF}��� {FFFF00}��� �����.{FFFFFF} 91) {DEB887}/an � {FFFFFF}�������� �������, ��� �������� �� {A0522D}������.{FFFFFF} 92) {7FFFD4}/hc � {FFFFFF}�������� �������, ��� ������ � ��� {EE82EE}��������.
{FFFFFF} 91) {8FBC8F}/stp � {FFFFFF}�������� ������, ��� ��������� {FF8C00}����� ������.
{FFFFFF} 93) {FF1493}/vr � {FFFFFF}�������� ������, ��� ������ � {1E90FF}ViP {FFFFFF}���.
{FFFFFF} 94) {3CB371}/ps � {FFFFFF}�������� ������, ��� �� {DAA520}�������.
{FFFFFF} 95) {FF7F50}/lok � {FFFFFF}�������� ������, ��� {00FF00}������� {FFFFFF}�/�.
{FFFFFF} 96) {FF4500}/sbo � {FFFFFF}�������� ������, ��� ����������� {FF6347}������� {FFFFFF}�� �������.
{FFFFFF} 97) {FFA500}/ing � {FFFFFF}�������� ������, ��� {FF0000}�� ���������{FFFFFF}/{FF0000}�� ��������.
{FFFFFF} 98) {FFA500}/chk � {FFFFFF}�������� ������, ��� ���������� ������ ��������� ��������.
{FFFFFF} 99) {FFA500}/dru � {FFFFFF}�������� ������, ��� ������������ ���������.
{FFFFFF} 100) {FFA500}/hou � {FFFFFF}�������� ������, ��� ����� ���� ���.
{FFFFFF} 101) {FFA500}/sobes � {FFFFFF}�������� ������, ����� ������� ���� ���������� ������ � ������/����.
{FFFFFF} 102) {FFA500}/pri � {FFFFFF}�������� ������, ��� ������� ���� � �����������.
{FFFFFF} 103) {FFA500}/invi � {FFFFFF}�������� ������, ��� �������� �� �������]], "{FFFFFF}�������", "", 4)
    end)
sampRegisterChatCommand("anak", function()
        sampShowDialog(1, "{FFF000}������� ������ ���������", [[
{b22222}������ {B22222}({FFFFFF}/jail{B22222}) {B22222}������� ��{FFFFFF}:
{B22222}* {FFFFFF}�������� ��� ������� (DM). ���������: 15 ����� /jail.
{B22222}* {FFFFFF}�������� ��� ������� � ������ ���� (DM ZZ). ���������: 20 ����� /jail.
{b22222}* {FFFFFF}�������� ������ ��������� ������� (��). ���������: 20 ����� /jail.
{B22222}* {FFFFFF}�������� � ������ (DB). ���������: 15 ����� /jail.
{B22222}* {FFFFFF}�������� ��� ������ (SK). ���������: 20 ����� /jail.
{B22222}* {FFFFFF}��� � �����. ���������: 10 ����� /jail
{B22222}* {FFFFFF}�����/�������� ��� ������ �����. ���������: 45 ����� /jail.
{B22222}* {FFFFFF}���� ��������. ���������: 20 ����� /jail.
{B22222}* {FFFFFF}Powergaming (����������� �� ���� �����). ���������: 15 ����� /jail.
{B22222}* {FFFFFF}NonRP ��������. ���������: 20 ����� /jail.

{FFD700}��� ������� ({FFFFFF}/rmute{FFd800}) ������� ��:
{FFD700}* {FFFFFF}������/������, �� ���������� ������� Luxwen RP. ���������: 15 ����� /rmute.
{FFD700}* {FFFFFF}������������ ���������. ���������: 60 ����� /rmute.
{FFD700}* {FFFFFF}Caps-Lock. ���������: 15 ����� /rmute.
{FFD700}* {FFFFFF}������������ �����/��������, �� ������� ��� ��� �����. ���������: 10 ����� /rmute.

{FFA500}��� ({FFFFFF}/mute{FFA500}) ������� ��:
{FFA500}* {FFFFFF}������������� ���������� �� ��������� ���� � ������� ��� (MG). ���������: 5 ����� /mute.
{FFA500}* {FFFFFF}����������� ������. ���������: 25 ����� /mute.
{FFA500}* {FFFFFF}����������� �������������. ���������: 180 ����� /mute.
{FFA500}* {FFFFFF}���������� ������ ������. ���������: 180 ����� /mute.
{FFA500}* {FFFFFF}Caps-Lock. ���������: 10 ����� /mute.
{FFA500}* {FFFFFF}Flood. ���������: 15 ����� /mute.
{FFA500}* {FFFFFF}������ ��������������� �����. ���������: 60 ����� /mute.
{FFA500}* {FFFFFF}������ ������� � ����� �� ����/������ ������ � ������ � ���������� ����������. ���������: 180 ����� /mute ��� 2 ��� /ban.
{FFA500}* {FFFFFF}������������ ���������. ���������: 45 ����� /mute ��� 7 ���� /ban.

{FC4347}�������������� ({FFFFFF}/warn{FC4347}) {FC4347}������� ��:
{FC4347}* {FFFFFF}�������� ��/��/��/��.
{FC4347}* {FFFFFF}NonRP ���.
{FC4347}* {FFFFFF}����� �� ����� ������.
{FC4347}* {FFFFFF}����� �� ����� �������������� �������������� ���������.

{FF0000}���������� �������� ({FFFFFF}/ban{FF0000}) ������� ��:
{FF0000}* {FFFFFF}������������� ����� ����� �����. ���������: 21 ���� /ban.
{FF0000}* {FFFFFF}����������� ������ ��������������/������. ���������: 21 ���� /ban.
{FF0000}* {FFFFFF}����������� �������. ���������: 30 ���� /ban.
{FF0000}* {FFFFFF}������������� ����� ����/������� � ��������� �����. ���������: 7 ���� /ban.
{FF0000}* {FFFFFF}������� ��������� ��������. ���������: 30 ���� /ban, /banip.
{FF0000}* {FFFFFF}����� �������������. ���������: 14-66 ���� ����.
{FF0000}* {FFFFFF}�������� ��������� (������� �������������� �� ���., ����������� ������� ������� � �.�.). ���������: ׸���� ������ ������� ��������.
{FF0000}* {FFFFFF}������ ������� � ����� �� ����/������ ������ � ������ � ���������� ����������. ���������: 2 ��� /ban.

                                             {FF0000}�������� ��������! {FFFFFF}��� ������������ ������� ��������� ����������.
                                             {FF0000}�������� ��������! {FFFFFF}�������� �� ����������� �� ���������������!
                                             � ��������� ������� � /ban �������� ��������� �� {FF0000}IP ������.
]], "{FFFFFF}�������", "", 0)
    end)
sampRegisterChatCommand("hrep", function()
        sampShowDialog(1, "{FFF000}������� ���������", [[
{FFFFFF}�� {228b22}2 {FFFFFF}������� ����������������� � {FFD700}100 ��������.
{FFFFFF}�� {228b22}3 {FFFFFF}������� ����������������� � {FFD700}200 ��������.
{FFFFFF}�� {228b22}4 {FFFFFF}������� ����������������� � {FFD700}300 ��������.
{FFFFFF}�� {228b22}5 {FFFFFF}������� ����������������� � {FFD700}400 ��������.
{FFFFFF}�� {228b22}6 {FFFFFF}������� ����������������� � {FFD700}500 ��������.
{FFFFFF}�� {228b22}7 {FFFFFF}������� ����������������� � {FFD700}600 ��������.
{FFFFFF}�� {228b22}8 {FFFFFF}������� ����������������� � {FFD700}700 ��������.
{FFFFFF}�� {228b22}9 {FFFFFF}������� ����������������� � {FFD700}750 ��������.
{FFFFFF}�� {228b22}10 {FFFFFF}������� ����������������� � {FFD700}800 ��������.
{FFFFFF}�� {228b22}11 {FFFFFF}������� ����������������� � {FFD700}1050 ��������.
{FFFFFF}�� {228b22}12 {FFFFFF}������� ����������������� � {FFD700}1200 ��������.

{FFFFFF}����� {FF6347}������� {FFFFFF}�� {228b22}�������:
{FF6347}1 {FFFFFF}������� � {FF6347}350 ��������.
{FF6347}2 {FFFFFF}�������� � {FF6347}700 ��������.
{FFFFFF}������ �� ��������� ������ ������ � Discord ������, � ������ {4169E1}#������.
{FFFFFF}�� ������ ������ {ff6347}��������{FFFFFF}, ���������� � {9400D3}����������� �� {FFFFFF}��� � {2681ff}�������� ��������������.]], "{FFFFFF}�������", "", 0)
    end)
sampRegisterChatCommand("ahelp", function()
        sampShowDialog(1, "{FFF000}������ ������ ��������������", [[
{7FFFD4}1 �������:
{FFFFFF}/anak - {7FFFD4}���������� ������� ������ ���������.
{FFFFFF}/aprav - {7FFFD4}���������� ������� �������������.
{FFFFFF}/mystats - {7FFFD4}���������� ���������� ��������������.
{FFFFFF}/agm - {7FFFD4}�������� ����������.
{FFFFFF}/a - {7FFFD4}��� ���������������.
{FFFFFF}/admins - {7FFFD4}������ ������������� online.
{FFFFFF}/pm - {7FFFD4}�������� ������.
{FFFFFF}/tp - {7FFFD4}������ ���������.
{FFFFFF}/re - {7FFFD4}������ �� �������.
{FFFFFF}/hp - {7FFFD4}��������� ���� �������� (100 hp).
{FFFFFF}/gg - {7FFFD4}�������� ������ �������� ����.
{FFFFFF}/spawn - {7FFFD4}���������� ������.
{FFFFFF}/wantedlist - {7FFFD4}������ ������������.
{FFFFFF}/mutelist - {7FFFD4}������ ������� � ����������� ����.
{FFFFFF}/jaillist - {7FFFD4}������ �������, ������� ��������� � ������.

{32CD32}2 �������:
{FFFFFF}/slap - {32CD32}��������� ������ �����.
{FFFFFF}/jail - {32CD32}�������� ������ � ������.
{FFFFFF}/chat - {32CD32}�������� �������� �������� ����.
{FFFFFF}/chatsms - {32CD32}�������� �������� SMS ���������.
{FFFFFF}/g(oto) - {32CD32}����������������� � ������.
{FFFFFF}/alock - {32CD32}������� ����� ������.
{FFFFFF}/freeze - {32CD32}���������� ������.
{FFFFFF}/unfreeze - {32CD32}����������� ������.

{3CB371}3 �������:
{FFFFFF}/skin - {3CB371}������� ���� ������.
{FFFFFF}/mark - {3CB371}���������� �����.
{FFFFFF}/gotomark - {3CB371}����������������� �� �������� �����.
{FFFFFF}/iwep - {3CB371}�������� ������ � ������.
{FFFFFF}/sethp - {3CB371}������� ������� �������� ������.
{FFFFFF}/warehouse - {3CB371}�������� ������ �����������.

{20B2AA}4 �������:
{FFFFFF}/jetpack - {20B2AA}������������ ���������� �����.
{FFFFFF}/stats - {20B2AA}������ ���������� ������ (������ ������� - /getstats).
{FFFFFF}/kickpb - {20B2AA}��������� ������ �� ������� � PaintBall.
{FFFFFF}/offmute - {20B2AA}������ ���������� ���� ������ � offline.
{FFFFFF}/offjail - {20B2AA}������ ������ ������ � offline.

{66CDAA}5 �������:
{FFFFFF}/kick - {66CDAA}������� ������.
{FFFFFF}/history - {66CDAA}�������� ���� ����� ������.
{FFFFFF}/delveh - {66CDAA}������� ��������� ��������� ���������������.
{FFFFFF}/fuelcars - {66CDAA}��������� ��� ������������ ��������.
{FFFFFF}/spawncars - {66CDAA}���������� ���� ��������� ��������� ��������.
{FFFFFF}/gethere - {66CDAA}��������������� ������ � ����.

{D8BFD8}6 �������:
{FFFFFF}/warn - {D8BFD8}������ �������������� ������.
{FFFFFF}/ptp - {D8BFD8}��������������� ������ � ������.
{FFFFFF}/givegun - {D8BFD8}������ ������ ������.
{FFFFFF}/balance - {D8BFD8}���������� ������ �����������.
{FFFFFF}/pgetip - {D8BFD8}��������� �� IP ������ ������� ��������� � ������.

{DDA0DD}7 �������:
{FFFFFF}/getoffstats - {DDA0DD}���������� ���������� ������ offline.
{FFFFFF}/setskin - {DDA0DD}������� ������ ������.
{FFFFFF}/warnmans - {DDA0DD}������ ������� � ��������������� (warn).
{FFFFFF}/offwarn - {DDA0DD}������ �������������� offline.
{FFFFFF}/ooc - {DDA0DD}����� ���.

{EE82EE}8 �������:
{FFFFFF}/ban - {EE82EE}������������� ������� ������.
{FFFFFF}/unban - {EE82EE}�������������� ������� ������.
{FFFFFF}/gzcolor - {EE82EE}�������������� � �����������.
{FFFFFF}/unwarn - {EE82EE}����� �������������� ������.
{FFFFFF}/dvall - {EE82EE}������� ���� ��������� ��������� ���������������.
{FFFFFF}/getip - {EE82EE}������ IP ����� ������ (REG IP - ����� ���������������, L IP - ��������� ����� �� ������, IP - ������ ������).
{FFFFFF}/spveh - {EE82EE}���������� ���� ��������� � �������.
{FFFFFF}/offgoto - {EE82EE}������ �� �������� � ����.

{FFD700}9 �������:
{FFFFFF}/aad - {FFD700}���������� �� ��������������.
{FFFFFF}/amembers - {FFD700}�������� ������ ����������� online.
{FFFFFF}/agl - {FFD700}������ ��� �������� ������.
{FFFFFF}/templeader - {FFD700}��������� ���� ��������� ������ �����������.
{FFFFFF}/getban - {A52A2A}������ ������� ���������� ��������.
{FFFFFF}/getbanip - {FFD700}������ ������� ���������� �������� �� IP ������.

{FFA500}10 �������:
{FFFFFF}/offban - {FFA500}������������� ������� offline.
{FFFFFF}/ghetto - {FFA500}��������� ������ ����� ���������.
{FFFFFF}/mpwin - {FFA500}������ ���� (�����-����).
{FFFFFF}/settp - {FFA500}���������� ����� ��������� ��� �������.
{FFFFFF}/givebil - {FFA500}������ ������� �����.
{FFFFFF}/givemedcard - {FFA500}������ ����������� �����.
{FFFFFF}/sban - {FFA500}���� ������������� �������.
{FFFFFF}/object - {FFA500}���������� ������� �� ����.
{FFFFFF}/uval - {FFA500}������� ������.
{FFFFFF}/setbizmafia - {FFA500}������ ������ �����.

{6A5ACD}11 �������:
{FFFFFF}/offleader - {6A5ACD}����� ������ offline.
{FFFFFF}/setleader - {6A5ACD}��������� ������ �� ���� ������.
{FFFFFF}/fid - {6A5ACD}���������� id �����������.
{FFFFFF}/noooc - {6A5ACD}��������/��������� ������ � ������ ����.
{FFFFFF}/mp - {6A5ACD}���� �����������.
{FFFFFF}/veh - {6A5ACD}������� ������.
{FFFFFF}/startpb - {6A5ACD}��������� PaintBall.
{FFFFFF}/startrace - {6A5ACD}��������� �����.
{FFFFFF}/startbase - {6A5ACD}��������� ������������.
{FFFFFF}/setmats - {6A5ACD}�������� ���������� ���������� ������������.

{FF6347}12 �������:
{FFFFFF}/offhelper - {FF6347}����� ������ ���������.
{FFFFFF}/agiverank - {FF6347}������ ������ ����.
{FFFFFF}/hstats - {FF6347}���������� ���������� ������ ���������.
{FFFFFF}/cc - {FF6347}�������� ���.
{FFFFFF}/sethelper - {FF6347}��������� �� ���� ������ ���������.
{FFFFFF}/skick - {FF6347}����� ���.
{FFFFFF}/iban - {FF6347}������������� ������� ������ ��������.
{FFFFFF}/hcheck - {FF6347}���������� ������ ����������.
{FFFFFF}/lip - {FF6347}��������� IP ������.
{FFFFFF}/unbanip - {FF6347}�������������� IP ������.
{FFFFFF}/banip - {FF6347}������������� �� IP ������.
{FFFFFF}/tpcor - {FF6347}����������������� �� ����������� �� x, y, z.
{FFFFFF}/atune - {FF6347}��������� ��������������.
{FFFFFF}/forceskin - {FF6347}��������� ������ � ������ �����.
{FFFFFF}/election - {FF6347}������� ������ ���������� � �����.
{FFFFFF}/agivevip - {FF6347}������ VIP ������.]], "{FFFFFF}�������", "", 4)
    end)
sampRegisterChatCommand("idguns", function()
        sampShowDialog(1, "{FFF000}ID ������", [[
{FFA500}1 � {6495ED}������.
{FFA500}2 � {6495ED}������ ��� ������.
{FFA500}3 � {6495ED}����������� �������.
{FFA500}4 � {6495ED}���.
{FFA500}5 � {6495ED}����������� ����.
{FFA500}6 � {6495ED}������.
{FFA500}7 � {6495ED}���������� ���.
{FFA500}8 � {6495ED}������.
{FFA500}9 � {6495ED}���������.
{FFA500}10 � {6495ED}���������� �����.
{FFA500}11 � {6495ED}�����.
{FFA500}12 � {6495ED}��������.
{FFA500}13 � {6495ED}����������� ��������.
{FFA500}14 � {6495ED}�����.
{FFA500}15 � {6495ED}������.
{FFA500}16 � {6495ED}�������.
{FFA500}17 � {6495ED}������������ ���.
{FFA500}18 � {6495ED}�������� ��������.
{FFA500}22 � {6495ED}��������.
{FFA500}23 � {6495ED}�������� � ����������.
{FFA500}24 � {6495ED}��������� ��� (Deagle).
{FFA500}25 � {6495ED}��������.
{FFA500}26 � {6495ED}�����.
{FFA500}27 � {6495ED}������ ��������.
{FFA500}28 � {6495ED}����� UZI.
{FFA500}29 � {6495ED}��-5.
{FFA500}30 � {6495ED}������� �����������.
{FFA500}31 � {6495ED}������� �4.
{FFA500}32 � {6495ED}���-9.
{FFA500}33 � {6495ED}�������� (Rifle).
{FFA500}34 � {6495ED}����������� ��������.
{FFA500}35 � {6495ED}���������.
{FFA500}36 � {6495ED}��������������� ���������.
{FFA500}37 � {6495ED}������.
{FFA500}38 � {6495ED}�������.
{FFA500}39 � {6495ED}����� �����.
{FFA500}40 � {6495ED}���������.
{FFA500}41 � {6495ED}�������� � �������.
{FFA500}42 � {6495ED}������������.
{FFA500}43 � {6495ED}�����������.
{FFA500}44 � {6495ED}���� ������� �������.
{FFA500}45 � {6495ED}���� ��������� �������.
{FFA500}46 � {6495ED}�������.]], "{FFFFFF}�������", "", 0)
    end)
sampRegisterChatCommand("idskins", function()
        sampShowDialog(1, "{FFF000}ID ������", [[
{FFA500}1 � {6495ED}The Truth.
{FFA500}2 � {6495ED}Maccer.
{FFA500}3 � {6495ED}Andre.
{FFA500}4 � {6495ED}Barry "Big Bear" Thorne [Thin].
{FFA500}5 � {6495ED}Barry "Big Bear" Thorne [Big].
{FFA500}6 � {6495ED}Emmet.
{FFA500}7 � {6495ED}Taxi Driver/Train Driver.
{FFA500}8 � {6495ED}Janitor.
{FFA500}9 � {6495ED}Normal Ped.
{FFA500}10 � {6495ED}Old Woman.
{FFA500}11 � {6495ED}Casino croupier.
{FFA500}12 � {6495ED}Rich woman
{FFA500}13 � {6495ED}Street Girl.
{FFA500}14 � {6495ED}Normal Ped.
{FFA500}15 � {6495ED}Mr.Whittaker (RS Haul Owner).
{FFA500}16 � {6495ED}Airport Ground Worker.
{FFA500}17 � {6495ED}Businessman.
{FFA500}18 � {6495ED}Beach Visitor.
{FFA500}19 � {6495ED}DJ.
{FFA500}20 � {6495ED}Rich Guy.
{FFA500}21 � {6495ED}Normal Ped.
{FFA500}22 � {6495ED}Normal Ped.
{FFA500}23 � {6495ED}BMXer.
{FFA500}24 � {6495ED}Madd Dogg Bodyguard.
{FFA500}25 � {6495ED}Madd Dogg Bodyguard.
{FFA500}26 � {6495ED}Backpacker.
{FFA500}27 � {6495ED}Construction Worker.
{FFA500}28 � {6495ED}Drug Dealer.
{FFA500}29 � {6495ED}Drug Dealer.
{FFA500}30 � {6495ED}Drug Dealer.
{FFA500}31 � {6495ED}Farm-Town inhabitant.
{FFA500}32 � {6495ED}Farm-Town inhabitant.
{FFA500}33 � {6495ED}Farm-Town inhabitant.
{FFA500}34 � {6495ED}Farm-Town inhabitant.
{FFA500}35 � {6495ED}Gardener.
{FFA500}36 � {6495ED}Golfer.
{FFA500}37 � {6495ED}Golfer.
{FFA500}38 � {6495ED}Normal Ped.
{FFA500}39 � {6495ED}Normal Ped (Old Woman).
{FFA500}40 � {6495ED}Normal Ped.
{FFA500}41 � {6495ED}Normal Ped.
{FFA500}42 � {6495ED}Jethro.
{FFA500}43 � {6495ED}Normal Ped.
{FFA500}44 � {6495ED}Normal Ped.
{FFA500}45 � {6495ED}Beach Visitor.
{FFA500}46 � {6495ED}Normal Ped
{FFA500}47 � {6495ED}Normal Ped.
{FFA500}48 � {6495ED}Normal Ped.
{FFA500}49 � {6495ED}Snakehead (Da Nang).
{FFA500}50 � {6495ED}Mechanic.
{FFA500}51 � {6495ED}Mountain Biker.
{FFA500}52 � {6495ED}Mountain Biker.
{FFA500}53 � {6495ED}Normal Ped (Old Woman).
{FFA500}54 � {6495ED}Normal Ped (Old Woman).
{FFA500}55 � {6495ED}Normal Ped.
{FFA500}56 � {6495ED}Normal Ped.
{FFA500}57 � {6495ED}Oriental Ped.
{FFA500}58 � {6495ED}Oriental Ped.
{FFA500}59 � {6495ED}Normal Ped.
{FFA500}60 � {6495ED}Normal Ped.
{FFA500}61 � {6495ED}Pilot.
{FFA500}62 � {6495ED}Colonel Fuhrberger.
{FFA500}63 � {6495ED}Prostitute.
{FFA500}64 � {6495ED}Prostitute.
{FFA500}65 � {6495ED}Kendl Johnson.
{FFA500}66 � {6495ED}Pool Player.
{FFA500}67 � {6495ED}Pool Player.
{FFA500}68 � {6495ED}Priest/Preacher.
{FFA500}69 � {6495ED}Normal Ped.
{FFA500}70 � {6495ED}Scientist.
{FFA500}71 � {6495ED}Security Guard.
{FFA500}72 � {6495ED}Hippy.
{FFA500}73 � {6495ED}Hippy.
{FFA500}75 � {6495ED}Prostitute.
{FFA500}76 � {6495ED}Stewardess.
{FFA500}77 � {6495ED}Homeless.
{FFA500}78 � {6495ED}Homeless.
{FFA500}79 � {6495ED}Homeless.
{FFA500}80 � {6495ED}Boxer.
{FFA500}81 � {6495ED}Boxer.
{FFA500}82 � {6495ED}Black Elvis.
{FFA500}83 � {6495ED}White Elvis.
{FFA500}84 � {6495ED}Blue Elvis.
{FFA500}85 � {6495ED}Prostitute.
{FFA500}86 � {6495ED}Ryder with robbery mask.
{FFA500}87 � {6495ED}Stripper.
{FFA500}88 � {6495ED}Normal Ped.
{FFA500}89 � {6495ED}Normal Ped.
{FFA500}90 � {6495ED}Jogger.
{FFA500}91 � {6495ED}Rich Woman.
{FFA500}92 � {6495ED}Rollerskater.
{FFA500}93 � {6495ED}Normal Ped.
{FFA500}94 � {6495ED}Normal Ped.
{FFA500}95 � {6495ED}Normal Ped.
{FFA500}96 � {6495ED}Jogger.
{FFA500}97 � {6495ED}Lifeguard.
{FFA500}98 � {6495ED}Normal Ped.
{FFA500}99 � {6495ED}Rollerskater.
{FFA500}100 � {6495ED}Biker.
{FFA500}101 � {6495ED}Normal Ped.
{FFA500}102 � {6495ED}Ballas 1.
{FFA500}103 � {6495ED}Ballas 2.
{FFA500}104 � {6495ED}Ballas 3.
{FFA500}105 � {6495ED}Grove Street Families 1.
{FFA500}106 � {6495ED}Grove Street Families 2.
{FFA500}107 � {6495ED}Grove Street Families 3.
{FFA500}108 � {6495ED}Los Santos Vagos 1.
{FFA500}109 � {6495ED}Los Santos Vagos 2.
{FFA500}110 � {6495ED}Los Santos Vagos 3.
{FFA500}111 � {6495ED}The Russian Mafia 1.
{FFA500}112 � {6495ED}The Russian Mafia 2.
{FFA500}113 � {6495ED}La Cosa Nostra 1.
{FFA500}114 � {6495ED}Varios Los Aztecas 1.
{FFA500}115 � {6495ED}Varios Los Aztecas 2.
{FFA500}116 � {6495ED}Varios Los Aztecas 3.
{FFA500}117 � {6495ED}Yakuza 1.
{FFA500}118 � {6495ED}Yakuza 2.
{FFA500}119 � {6495ED}Johhny Sindacco.
{FFA500}120 � {6495ED}Yakuza 3.
{FFA500}121 � {6495ED}Da Nang Boy 1.
{FFA500}122 � {6495ED}Da Nang Boy 2.
{FFA500}123 � {6495ED}Yakuza 4.
{FFA500}124 � {6495ED}La Cosa Nostra 2.
{FFA500}125 � {6495ED}The Russian Mafia 3.
{FFA500}126 � {6495ED}The Russian Mafia 4.
{FFA500}127 � {6495ED}La Cosa Nostra 3.
{FFA500}128 � {6495ED}Farm Inhabitant.
{FFA500}129 � {6495ED}Farm Inhabitant.
{FFA500}130 � {6495ED}Farm Inhabitant.
{FFA500}131 � {6495ED}Farm Inhabitant.
{FFA500}132 � {6495ED}Farm Inhabitant.
{FFA500}133 � {6495ED}Farm Inhabitant.
{FFA500}134 � {6495ED}Homeless.
{FFA500}135 � {6495ED}Normal Ped.
{FFA500}136 � {6495ED}Homeless.
{FFA500}137 � {6495ED}Beach Visitor.
{FFA500}138 � {6495ED}Beach Visitor.
{FFA500}139 � {6495ED}Beach Visitor.
{FFA500}140 � {6495ED}Beach Visitor.
{FFA500}141 � {6495ED}Businesswoman.
{FFA500}142 � {6495ED}Taxi Driver.
{FFA500}143 � {6495ED}Crack Maker.
{FFA500}144 � {6495ED}Crack Maker.
{FFA500}145 � {6495ED}Crack Maker.
{FFA500}146 � {6495ED}Crack Maker.
{FFA500}147 � {6495ED}Businesswoman.
{FFA500}148 � {6495ED}Businesswoman.
{FFA500}149 � {6495ED}Big Smoke Armored.
{FFA500}150 � {6495ED}Businesswoman.
{FFA500}151 � {6495ED}Normal Ped.
{FFA500}152 � {6495ED}Prostitute.
{FFA500}153 � {6495ED}Construction Worker.
{FFA500}154 � {6495ED}Beach Visitor.
{FFA500}155 � {6495ED}Well Stacked Pizza Worker.
{FFA500}156 � {6495ED}Barber.
{FFA500}157 � {6495ED}Hillbilly.
{FFA500}158 � {6495ED}Farmer.
{FFA500}159 � {6495ED}Hillbilly.
{FFA500}160 � {6495ED}Hillbilly.
{FFA500}161 � {6495ED}Farmer.
{FFA500}162 � {6495ED}Hillbilly.
{FFA500}163 � {6495ED}Black Bouncer.
{FFA500}164 � {6495ED}White Bouncer.
{FFA500}165 � {6495ED}White MIB agent.
{FFA500}166 � {6495ED}Black MIB agent.
{FFA500}167 � {6495ED}Cluckin' Bell Worker.
{FFA500}168 � {6495ED}Hotdog/Chilli Dog Vendor.
{FFA500}169 � {6495ED}Normal Ped.
{FFA500}170 � {6495ED}Normal Ped.
{FFA500}171 � {6495ED}Blackjack Dealer.
{FFA500}172 � {6495ED}Casino croupier.
{FFA500}173 � {6495ED}San Fierro Rifa 1.
{FFA500}174 � {6495ED}San Fierro Rifa 2.
{FFA500}175 � {6495ED}San Fierro Rifa 3.
{FFA500}176 � {6495ED}Barber.
{FFA500}177 � {6495ED}Barber.
{FFA500}179 � {6495ED}Whore.
{FFA500}180 � {6495ED}Ammunation Salesman.
{FFA500}181 � {6495ED}Tattoo Artist.
{FFA500}182 � {6495ED}Cab Driver.
{FFA500}183 � {6495ED}Normal Ped.
{FFA500}184 � {6495ED}Normal Ped.
{FFA500}185 � {6495ED}Normal Ped.
{FFA500}186 � {6495ED}Normal Ped.
{FFA500}187 � {6495ED}Businessman.
{FFA500}188 � {6495ED}Normal Ped.
{FFA500}189 � {6495ED}Valet.
{FFA500}190 � {6495ED}Barbara Schternvart.
{FFA500}191 � {6495ED}Helena Wankstein.
{FFA500}192 � {6495ED}Michelle Cannes.
{FFA500}193 � {6495ED}Katie Zhan.
{FFA500}194 � {6495ED}Millie Perkins.
{FFA500}195 � {6495ED}Denise Robinson.
{FFA500}196 � {6495ED}Farm-Town inhabitant.
{FFA500}197 � {6495ED}Hillbilly.
{FFA500}198 � {6495ED}Farm-Town inhabitant.
{FFA500}199 � {6495ED}Farm-Town inhabitant.
{FFA500}200 � {6495ED}Hillbilly.
{FFA500}201 � {6495ED}Farmer.
{FFA500}202 � {6495ED}Farmer.
{FFA500}203 � {6495ED}Karate Teacher.
{FFA500}204 � {6495ED}Karate Teacher.
{FFA500}205 � {6495ED}Burger Shot Cashier.
{FFA500}206 � {6495ED}Cab Driver.
{FFA500}207 � {6495ED}Prostitute.
{FFA500}208 � {6495ED}Su Xi Mu (Suzie).
{FFA500}209 � {6495ED}Oriental Noodle stand vendor.
{FFA500}210 � {6495ED}Boating School Instructor.
{FFA500}211 � {6495ED}Clothes shop staff.
{FFA500}212 � {6495ED}Homeless.
{FFA500}213 � {6495ED}Weird old man.
{FFA500}214 � {6495ED}Waitress (Maria Latore).
{FFA500}215 � {6495ED}Normal Ped.
{FFA500}216 � {6495ED}Normal Ped.
{FFA500}217 � {6495ED}Clothes shop staff.
{FFA500}218 � {6495ED}Normal Ped.
{FFA500}219 � {6495ED}Rich Woman.
{FFA500}220 � {6495ED}Cab Driver.
{FFA500}221 � {6495ED}Normal Ped.
{FFA500}222 � {6495ED}Normal Ped.
{FFA500}223 � {6495ED}Normal Ped.
{FFA500}224 � {6495ED}Normal Ped.
{FFA500}225 � {6495ED}Normal Ped.
{FFA500}227 � {6495ED}Oriental Businessman.
{FFA500}228 � {6495ED}Oriental Ped.
{FFA500}229 � {6495ED}Oriental Ped.
{FFA500}230 � {6495ED}Homeless.
{FFA500}231 � {6495ED}Normal Ped.
{FFA500}232 � {6495ED}Normal Ped.
{FFA500}233 � {6495ED}Normal Ped.
{FFA500}234 � {6495ED}Cab Driver.
{FFA500}235 � {6495ED}Normal Ped.
{FFA500}236 � {6495ED}Normal Ped.
{FFA500}237 � {6495ED}Prostitute.
{FFA500}238 � {6495ED}Prostitute.
{FFA500}239 � {6495ED}Homeless.
{FFA500}240 � {6495ED}The D.A.
{FFA500}241 � {6495ED}Afro-American.
{FFA500}242 � {6495ED}Mexican.
{FFA500}243 � {6495ED}Prostitute.
{FFA500}244 � {6495ED}Stripper.
{FFA500}245 � {6495ED}Prostitute.
{FFA500}246 � {6495ED}Stripper.
{FFA500}247 � {6495ED}Biker.
{FFA500}248 � {6495ED}Biker.
{FFA500}249 � {6495ED}Pimp.
{FFA500}250 � {6495ED}Normal Ped.
{FFA500}251 � {6495ED}Lifeguard.
{FFA500}252 � {6495ED}Naked Valet.
{FFA500}253 � {6495ED}Bus Driver.
{FFA500}254 � {6495ED}Biker Drug Dealer.
{FFA500}255 � {6495ED}Chauffeur (Limo Driver).
{FFA500}256 � {6495ED}Stripper.
{FFA500}257 � {6495ED}Stripper.
{FFA500}258 � {6495ED}Heckler.
{FFA500}259 � {6495ED}Heckler.
{FFA500}260 � {6495ED}Construction Worker.
{FFA500}261 � {6495ED}Cab driver.
{FFA500}262 � {6495ED}Cab driver.
{FFA500}263 � {6495ED}Normal Ped.
{FFA500}264 � {6495ED}Clown.
{FFA500}265 � {6495ED}Officer Frank Tenpenny.
{FFA500}266 � {6495ED}Officer Eddie Pulaski.
{FFA500}267 � {6495ED}Officer Jimmy Hernandez.
{FFA500}268 � {6495ED}Dwaine/Dwayne.
{FFA500}269 � {6495ED}Melvin "Big Smoke" Harris.
{FFA500}270 � {6495ED}Sean 'Sweet' Johnson.
{FFA500}271 � {6495ED}Lance 'Ryder' Wilson.
{FFA500}272 � {6495ED}The Russian Mafia Boss.
{FFA500}273 � {6495ED}T-Bone Mendez.
{FFA500}274 � {6495ED}Paramedic.
{FFA500}275 � {6495ED}Paramedic.
{FFA500}276 � {6495ED}Paramedic.
{FFA500}277 � {6495ED}Firefighter.
{FFA500}278 � {6495ED}Firefighter.
{FFA500}279 � {6495ED}Firefighter.
{FFA500}280 � {6495ED}Los Santos Police Officer.
{FFA500}281 � {6495ED}San Fierro Police Officer.
{FFA500}282 � {6495ED}Las Venturas Police Officer.
{FFA500}283 � {6495ED}County Sheriff.
{FFA500}284 � {6495ED}LSPD Motorbike Cop.
{FFA500}285 � {6495ED}SWAT Special Forces.
{FFA500}286 � {6495ED}Federal Agent.
{FFA500}287 � {6495ED}San Andreas Army.
{FFFFFF}288 � {6495ED}Desert Sheriff.
{FFA500}289 � {6495ED}Zero.
{FFA500}290 � {6495ED}Ken Rozenberg.
{FFA500}291 � {6495ED}Kent Paul.
{FFA500}292 � {6495ED}Cesar Vialpando.
{FFA500}293 � {6495ED}Jeffery "OG Loc" Martin/Cross.
{FFA500}294 � {6495ED}Wu Zi Mu (Woozie).
{FFA500}295 � {6495ED}Michael Toreno.
{FFA500}296 � {6495ED}Jizzy B.
{FFA500}297 � {6495ED}Madd Dogg.
{FFA500}298 � {6495ED}Catalina.
{FFA500}299 � {6495ED}Claude Speed.
{FFA500}300 � {6495ED}Los Santos Police Officer.
{FFA500}301 � {6495ED}San Fierro Police Officer.
{FFA500}302 � {6495ED}Las Venturas Police Officer.
{FFA500}303 � {6495ED}Los Santos Police Officer.
{FFA500}304 � {6495ED}Los Santos Police Officer.
{FFA500}305 � {6495ED}Las Venturas Police Officer.
{FFA500}306 � {6495ED}Los Santos Police Officer.
{FFA500}307 � {6495ED}San Fierro Police Officer.
{FFA500}308 � {6495ED}San Fierro Paramedic.
{FFA500}309 � {6495ED}Las Venturas Police Officer.
{FFA500}310 � {6495ED}Country Sheriff (Without hat).
{FFA500}311 � {6495ED}Desert Sheriff (Without hat).]], "{FFFFFF}�������", "", 4)
    end)
sampRegisterChatCommand("idcars", function()
        sampShowDialog(1, "{FFF000}ID ������������ �������", [[
{FFA500}400 � {6495ED}Landstalker.
{FFA500}401 � {6495ED}Bravura.
{FFA500}402 � {6495ED}Buffalo.
{FFA500}403 � {6495ED}Linerunner.
{FFA500}404 � {6495ED}Perennial.
{FFA500}405 � {6495ED}Sentinel.
{FFA500}406 � {6495ED}Dumper.
{FFA500}407 � {6495ED}Firetruck.
{FFA500}408 � {6495ED}Trashmaster.
{FFA500}409 � {6495ED}Stretch.
{FFA500}410 � {6495ED}Manana.
{FFA500}411 � {6495ED}Infernus.
{FFA500}412 � {6495ED}Voodoo.
{FFA500}413 � {6495ED}Pony.
{FFA500}414 � {6495ED}Mule.
{FFA500}415 � {6495ED}Cheetah.
{FFA500}416 � {6495ED}Ambulance.
{FFA500}417 � {6495ED}Leviathan.
{FFA500}418 � {6495ED}Moonbeam.
{FFA500}419 � {6495ED}Esperanto.
{FFA500}420 � {6495ED}Taxi.
{FFA500}421 � {6495ED}Washington.
{FFA500}422 � {6495ED}Bobcat.
{FFA500}423 � {6495ED}Mr. Whoopee.
{FFA500}424 � {6495ED}BF Injection.
{FFA500}425 � {6495ED}Hunter.
{FFA500}426 � {6495ED}Premier.
{FFA500}427 � {6495ED}Enforcer.
{FFA500}428 � {6495ED}Securi Car.
{FFA500}429 � {6495ED}Banshee.
{FFA500}430 � {6495ED}Predator.
{FFA500}431 � {6495ED}Bus.
{FFA500}432 � {6495ED}Rhino.
{FFA500}433 � {6495ED}Barracks.
{FFA500}434 � {6495ED}Hotknife.
{FFA500}435 � {6495ED}Article Trailer.
{FFA500}436 � {6495ED}Previon.
{FFA500}437 � {6495ED}Coach.
{FFA500}438 � {6495ED}Cabbie.
{FFA500}439 � {6495ED}Stallion.
{FFA500}440 � {6495ED}Rumpo.
{FFA500}441 � {6495ED}RC Bandit.
{FFA500}442 � {6495ED}Romero.
{FFA500}443 � {6495ED}Packer.
{FFA500}444 � {6495ED}Monster.
{FFA500}445 � {6495ED}Admiral.
{FFA500}446 � {6495ED}Squallo.
{FFA500}447 � {6495ED}Seasparrow.
{FFA500}448 � {6495ED}Pizzaboy.
{FFA500}449 � {6495ED}Tram.
{FFA500}450 � {6495ED}Article Trailer 2.
{FFA500}451 � {6495ED}Turismo.
{FFA500}452 � {6495ED}Speeder.
{FFA500}453 � {6495ED}Reefer.
{FFA500}454 � {6495ED}Tropic.
{FFA500}455 � {6495ED}Flatbed.
{FFA500}456 � {6495ED}Yankee.
{FFA500}457 � {6495ED}Caddy.
{FFA500}458 � {6495ED}Solair.
{FFA500}459 � {6495ED}Topfun Van (Berkley's RC).
{FFA500}460 � {6495ED}Skimmer.
{FFA500}461 � {6495ED}PCJ-600.
{FFA500}462 � {6495ED}Faggio.
{FFA500}463 � {6495ED}Freeway.
{FFA500}464 � {6495ED}RC Baron.
{FFA500}465 � {6495ED}RC Raider.
{FFA500}466 � {6495ED}Glendale.
{FFA500}467 � {6495ED}Oceanic.
{FFA500}468 � {6495ED}Sanchez.
{FFA500}469 � {6495ED}Sparrow.
{FFA500}470 � {6495ED}Patriot.
{FFA500}471 � {6495ED}Quad.
{FFA500}472 � {6495ED}Coastguard.
{FFA500}473 � {6495ED}Dinghy.
{FFA500}474 � {6495ED}Hermes.
{FFA500}475 � {6495ED}Sabre.
{FFA500}476 � {6495ED}Rustler.
{FFA500}477 � {6495ED}ZR-350.
{FFA500}478 � {6495ED}Walton.
{FFA500}479 � {6495ED}Regina.
{FFA500}480 � {6495ED}Comet.
{FFA500}481 � {6495ED}BMX.
{FFA500}482 � {6495ED}Burrito.
{FFA500}483 � {6495ED}Camper.
{FFA500}484 � {6495ED}Marquis.
{FFA500}485 � {6495ED}Baggage.
{FFA500}486 � {6495ED}Dozer.
{FFA500}487 � {6495ED}Maverick.
{FFA500}488 � {6495ED}SAN News Maverick.
{FFA500}489 � {6495ED}Rancher.
{FFA500}490 � {6495ED}FBI Rancher.
{FFA500}491 � {6495ED}Virgo.
{FFA500}492 � {6495ED}Greenwood.
{FFA500}493 � {6495ED}Jetmax.
{FFA500}494 � {6495ED}Hotring Racer.
{FFA500}495 � {6495ED}Sandking.
{FFA500}496 � {6495ED}Blista Compact.
{FFA500}497 � {6495ED}Police Maverick.
{FFA500}498 � {6495ED}Boxville.
{FFA500}499 � {6495ED}Benson.
{FFA500}500 � {6495ED}Mesa.
{FFA500}501 � {6495ED}RC Goblin.
{FFA500}502 � {6495ED}Hotring Racer A.
{FFA500}503 � {6495ED}Hotring Racer B.
{FFA500}504 � {6495ED}Bloodring Banger.
{FFA500}505 � {6495ED}Rancher Lure.
{FFA500}506 � {6495ED}Super GT.
{FFA500}507 � {6495ED}Elegant.
{FFA500}508 � {6495ED}Journey.
{FFA500}509 � {6495ED}Bike.
{FFA500}510 � {6495ED}Mountain Bike.
{FFA500}511 � {6495ED}Beagle.
{FFA500}512 � {6495ED}Croapduster.
{FFA500}513 � {6495ED}Stuntplane.
{FFA500}514 � {6495ED}Tanker.
{FFA500}515 � {6495ED}Roadtrain.
{FFA500}516 � {6495ED}Nebula.
{FFA500}517 � {6495ED}Majestic.
{FFA500}518 � {6495ED}Buccaneer.
{FFA500}519 � {6495ED}Shamal.
{FFA500}520 � {6495ED}Hydra.
{FFA500}521 � {6495ED}FCR-900.
{FFA500}522 � {6495ED}NRG-500.
{FFA500}523 � {6495ED}HPV1000.
{FFA500}524 � {6495ED}Cement Truck.
{FFA500}525 � {6495ED}Towtruck.
{FFA500}526 � {6495ED}Fortune.
{FFA500}527 � {6495ED}Cadrona.
{FFA500}528 � {6495ED}FBI Truck.
{FFA500}529 � {6495ED}Willard.
{FFA500}530 � {6495ED}Forklift.
{FFA500}531 � {6495ED}Tractor.
{FFA500}532 � {6495ED}Combine Harvester.
{FFA500}533 � {6495ED}Feltzer.
{FFA500}534 � {6495ED}Remington.
{FFA500}535 � {6495ED}Slamvan.
{FFA500}536 � {6495ED}Blade.
{FFA500}537 � {6495ED}Freight (Train).
{FFA500}538 � {6495ED}Brownstreak (Train).
{FFA500}539 � {6495ED}Vortex.
{FFA500}540 � {6495ED}Vincent.
{FFA500}541 � {6495ED}Bullet.
{FFA500}542 � {6495ED}Clover.
{FFA500}543 � {6495ED}Sadler.
{FFA500}544 � {6495ED}Firetruck LA.
{FFA500}545 � {6495ED}Hustler.
{FFA500}546 � {6495ED}Intruder.
{FFA500}547 � {6495ED}Primo.
{FFA500}548 � {6495ED}Cargobob.
{FFA500}549 � {6495ED}Tampa.
{FFA500}550 � {6495ED}Sunrise.
{FFA500}551 � {6495ED}Merit.
{FFA500}552 � {6495ED}Utility Van.
{FFA500}553 � {6495ED}Nevada.
{FFA500}554 � {6495ED}Yosemite.
{FFA500}555 � {6495ED}Windsor.
{FFA500}556 � {6495ED}Monster "A".
{FFA500}557 � {6495ED}Monster "B".
{FFA500}558 � {6495ED}Uranus.
{FFA500}559 � {6495ED}Jester.
{FFA500}560 � {6495ED}Sultan.
{FFA500}561 � {6495ED}Stratum.
{FFA500}562 � {6495ED}Elegy.
{FFA500}563 � {6495ED}Raindance.
{FFA500}564 � {6495ED}RC Tiger.
{FFA500}565 � {6495ED}Flash.
{FFA500}566 � {6495ED}Tahoma.
{FFA500}567 � {6495ED}Savanna.
{FFA500}568 � {6495ED}Bandito.
{FFA500}569 � {6495ED}Freight Flat Trailer (Train.
{FFA500}570 � {6495ED}Streak Trailer (Train).
{FFA500}571 � {6495ED}Kart.
{FFA500}572 � {6495ED}Mower.
{FFA500}573 � {6495ED}Dune.
{FFA500}574 � {6495ED}Sweeper.
{FFA500}575 � {6495ED}Broadway.
{FFA500}576 � {6495ED}Tornado.
{FFA500}577 � {6495ED}AT400.
{FFA500}578 � {6495ED}DFT-30.
{FFA500}579 � {6495ED}Huntley.
{FFA500}580 � {6495ED}Stafford.
{FFA500}581 � {6495ED}BF-400.
{FFA500}582 � {6495ED}Newsvan.
{FFA500}583 � {6495ED}Tug.
{FFA500}584 � {6495ED}Petrol Trailer.
{FFA500}585 � {6495ED}Emperor.
{FFA500}586 � {6495ED}Wayfarer.
{FFA500}587 � {6495ED}Euros.
{FFA500}588 � {6495ED}Hotdog.
{FFA500}589 � {6495ED}Club.
{FFA500}590 � {6495ED}Freight Box Trailer (Train).
{FFA500}591 � {6495ED}Article Trailer 3.
{FFA500}592 � {6495ED}Andromada.
{FFA500}593 � {6495ED}Dodo.
{FFA500}594 � {6495ED}RC Cam.
{FFA500}595 � {6495ED}Launch.
{FFA500}596 � {6495ED}Police Car (LSPD).
{FFA500}597 � {6495ED}Police Car (SFPD).
{FFA500}598 � {6495ED}Police Car (LVPD).
{FFA500}599 � {6495ED}Police Ranger.
{FFA500}600 � {6495ED}Picador.
{FFA500}601 � {6495ED}SWAT.
{FFA500}602 � {6495ED}Alpha.
{FFA500}603 � {6495ED}Phoenix.
{FFA500}604 � {6495ED}Glendale Shit.
{FFA500}605 � {6495ED}Sadler Shit.
{FFA500}606 � {6495ED}Baggage Trailer "A".
{FFA500}607 � {6495ED}Baggage Trailer "B".
{FFA500}608 � {6495ED}Tug Stairs Trailer.
{FFA500}609 � {6495ED}Boxville 2.
{FFA500}610 � {6495ED}Farm Trailer.
{FFA500}611 � {6495ED}Utility Trailer.]], "{FFFFFF}�������", "", 4)
    end)
sampRegisterChatCommand("mphelp", function()
sampShowDialog(1, "{FFF000}������� ���������� �����������", [[
I. {F0E68C}�������� ������� ���������� �����������:
{FF8C00}1.1. {4169E1}������������� ����� �������� �����������, ���� � ���� ���� ��������� ����� �� ������ �� ��������.
{FF8C00}1.2. {4169E1}��������������� ����������� ��������� ������� �� ������������: "PaintBall", "������� �������".
{FF8C00}1.3. {4169E1}�������������, ������� ����� �������� �����������, ������ ������, ������ �� /aad, /mp.
{FF8C00}1.4. {4169E1}���������������, � ������� ���� ������ � ������� "/givebilet" - ...
{FF8C00}... {4169E1}����������� ��������� �������������� ���������� ����������� �� 5 Luxwen-�������.
{FF8C00}1.5. {4169E1}�������������, ������� ����� ��������� �����������...
{FF8C00}... {4169E1}������ ������� ��� ��� �������� �����. ����������: {FFD700}/msg [��].
{FF8C00}1.6. {4169E1}�������������, ������� ����� ��������� �����������, ������ �������:
{FF8C00}... {4169E1}�������� �����������, ������������ �����.
������: �� | �������� ����������� � "������� �������". ����: 2 Luxwen ������(/gomp).
{FF8C00}1.7. {4169E1}�������� ������ ���������� ����������� �� ����������� ��� �� ���������������.

{FF8C00}II. {4169E1}����������� �� ����� ���������� �����������:
{FF8C00}2.1. {4169E1}��������� ���� �����������, ������� �� �������� ������� �������.
{FF8C00}2.2. {4169E1}��������� ����������� �� �����-����, �����, VIP ������, ����, ����������, Luxwen-������, ������� ������.
{FF8C00}2.3. {4169E1}��������� ����������� � ����� ���������������, ������� ����� ����� � ���� �� ������.
{FF8C00}2.4. {4169E1}��������� ����������� ����� ����� ��� (/aad ��� /msg)...
{FF8C00}... {4169E1}�� ��� ����, ������ �� ������ ��������� ����� ������, � ����� SMS ����������� ����������� ��������������.
{FF8C00}2.5. {4169E1}�������/�������� ������, ���� ��� �������� ������� ������� � ������������� ������� ���������������.
{FF8C00}2.6. {4169E1}��������� ��������� �����������.
{FF8C00}2.7. {4169E1}��������� ����������� ��������� � ������� �������� (�������� �����������).
{FFFFFF}
{FF8C00}III. {4169E1}����������� �� ����� ���������� �����������:
{FF8C00}3.1. {4169E1}����������� �� �����������, ���� �� ������� �������� �� ������� �� ������������ �����������.
{FF8C00}3.2. {4169E1}����������� ��������� ����������� �� ��� ����, ������� �� ������ ������.
{FF8C00}3.3. {4169E1}�����������: ������/�����������������/��������/������� ������������ �����������.
{FF8C00}3.4. {4169E1}����������� ��������/������� ������ ��� �������.
{FF8C00}3.5. {4169E1}����������� ������ ����, ������� �����������.
{FF8C00}3.6. {4169E1}����������� �������� ������ �� ����� �����������.
{FF8C00}3.7. {4169E1}����������� ��������� ������ �����������, ���� ����������� �������� ��� ������ �������������.
{FF8C00}3.8. {4169E1}����������� ��������� ����������� ����� ������.
{FF8C00}3.9. {4169E1}����������� ��������� ����������� ��: �����. �����, ����� ������...
{FF8C00}... {4169E1}����� ������ ��������� (����� �������� ������ �� ��� �� �������� ���������), �����.
{FFFFFF}
{FFD700}������� ��� ���������� �����������:
 /mp � {FF8C00}���� �� ���������� �����������.
 /settp � {FF8C00}�������/������� ����� ��������� ��� ������������ �� �����������.
 /mpwin � {FF8C00}������ �����-����.
 /givebilet � {FF8C00}������ Luxwen-�����.
 /startpb � {FF8C00}��������� PaintBall.
 /startrace � {FF8C00}��������� �����.
 /startbase � {FF8C00}��������� ������������.
]], "{FFFFFF}�������", "", 4)
    end)
sampRegisterChatCommand("obi", function()
        sampShowDialog(5, " ", [[
{FFD700}/apm � {FFFFFF}������������.
{FFD700}/anak � {FFFFFF}������� ������ ���������.
{FFD700}/aprav � {FFFFFF}������� �������������.
{FFD700}/mphelp � {FFFFFF}������� ���������� �����������.
{FFD700}/predit � {FFFFFF}������� �������������� ����������.
{FFD700}/hrep � {FFFFFF}���������� ���������� � ������� ���������.
{FFD700}/ahelp � {FFFFFF}���������� ���� ������ ������ ������������� �� ���������.
{FFF000}/top � {FFFFFF}��� ���������������.
{FFD700}/staff � {FFFFFF}������ ������� �������������.
{FFD700}/html � {FFFFFF}HTML �����.
{FFD700}/idguns � {FFFFFF}ID ������.
{FFD700}/idcars � {FFFFFF}ID ������������ �������.
{FFD700}/idskins � {FFFFFF}ID ������.
{FFD700}/fid � {FFFFFF}ID �����������.
{FFD700}/info � {FFFFFF}���������� ����������.
]], "{FFFFFF}�������", "", 0)
    end)
sampRegisterChatCommand("fid", function()
        sampShowDialog(2, "������ �����������", [[
{FFFFFF}1. {4169E1}LSPD
{FFFFFF}2. {2e2c2c}FBI
{7FFFD4}3. {A0522D}����� ���������
{7FFFD4}4. {DB7093}�������� �. ���-������
{FFFFFF}5. {DAA520}La Cosa Nostra
{FFFFFF}6. {FF0000}Yakuza
{FFFFFF}7. {4682B4}�����
{7FFFD4}10. {4169E1}RCSD
{FFFFFF}12. {9400D3}East Side Ballas
{FFFFFF}13. {FFD700}Los Santos Vagos
{FFFFFF}14. {D3D3D3}Russian Mafia
{FFFFFF}15. {228B22}West Side Grove
{7FFFD4}16. {FF8C00}Sa News
{FFFFFF}17. {00FFFF}Varrios Los Aztecas
{FFFFFF}18. {6495ED}East Coast Rifa
{FFFFFF}19. {A0522D}����� �. ���-������
{7FFFD4}21. {4169E1}NATD
{FFFFFF}23. {A9A9A9}Hitmans
{FFFFFF}25. {2E8B57}SWAT
{FFFFFF}26. {FFFF00}������������� ����������]], "{FFFFFF}�������", "", 0)
    end)
sampRegisterChatCommand("info", function()
        sampShowDialog(5, "{FFF000}����������", [[
{FFD700}��������� ������� ����������.

{FFFFFF}_________________________________________________

{FFFFFF}��������� ���������: {FFFFFF}vk.com/obikenobii.
{FFFFFF}��������� ����������:{FF8C00} 4 ����� 2022.
{FFFFFF}������ ������: {FFFFFF}/obi

]], "{FFFFFF}�������", "", 0)
    end)
sampRegisterChatCommand("staff", function()
        sampShowDialog(5, "{FFf000}�������������", [[
{FF0000} ���������� {FFFFFF}� Cavallaro ({4169E1}vk.com/cavallaro13{FFFFFF}).
{FF0000} ���������� {FFFFFF}� Saxarok ({4169E1}vk.com/os170{FFFFFF}).
{FF0000} ����������� ���������� {FFFFFF}� Ademi_Bala ({4169E1}vk.com/rm_ramil{FFFFFF}).
{FF0000} �������� ���. ���������� {FFFFFF}� Kenobi ({4169e1}vk.com/obikenobii{FFFFFF}).

{2681ff} ������� ������������� {FFFFFF}� iceberg ({4169E1}vk.com/obikenobii{FFFFFF}).
{8A2BE2} ����������� �������� �������������� {FFFFFF}� Blayze_Scaletta({4169E1}vk.com/ugenrl{FFFFFF}).

{8B0000} ������� ����������� ����������� {FFFFFF}� Blayze_Noufam ({4169E1}vk.com/ugenrl{FFFFFF}).
{008080} ������� ��������������� �������� {FFFFFF}� -({4169E1}vk.com/{FFFFFF}).

{AFEEEE} ������� �������� �� ���������������� ����������� {FFFFFF}� Angelo_Santini({4169E1}vk.com/kortese{FFFFFF}).
{228b22} ������� �������� �� ����������� ������������� {FFFFFF}� Pablo_Parlament ({4169E1}vk.com/tom_torres{FFFFFF}).
{A0522D} ������� �������� �� ���������� ����������� {FFFFFF}� Shay_Danoe ({4169E1}vk.com/jopareal{FFFFFF}).
]], "{FFFFFF}�������", "", 0)
    end)
sampRegisterChatCommand("�������", function()
        sampShowDialog(5, "{FF0000}������� �������������", [[
{FF0000}��������� ���������� {FFFFFF}04.03.2022
{FFD700}����������� �������������� �� �������:
{FFD700}� {FFFFFF}������������� ������ �������� ������� ������� ���� ��� ������ �� � /rep.
{FFD700}� {FFFFFF}������������� ������ �� 1 ���� �������� 120 �����, � ���-�� �������� �� ���� ��� ������� �� 50 ��������.
{FFD700}� {FFFFFF}������������� ������ ������������� �����, ����� ������ ��������� ������.
{FFD700}� {FFFFFF}������������� ������ ���� ���������, ����� ���������, ������� � �������� ������������� ���� ����.
{FFD700}� {FFFFFF}������������� ������ ������� � ���� ������� ����������� - ��� �������, ��� � ��� ������� �������������.
{FFD700}� {FFFFFF}������������� ������ ����� �������������� �� ��������� �� ������� ������.
{FFD700}� {FFFFFF}������������� ������ �������� ������� ������������� � ��������� ������ �� ��������������.
{FFD700}� {FFFFFF}������������� ������ ��������� ���������� ����� �������� ������� - 120 ����� � �����.
{FFD700}� {FFFFFF}������������� ������ ��� ������ ��������� ����� �������������� ���������.
{FFD700}� {FFFFFF}������������� ������ ������� ���������� � �������� �������, ���� ���� ����� ��� ����.
{FFD700}� {FFFFFF}������������� ������ ��������� ��������� � ������� ��� ��� ���� ��� ������.
{FFD700}� {FFFFFF}������������� ������ � /msg - /o ������� ������ ���. ��������: [��], [�����], [INFO] � ���� ��������.
{FFD700}� {FFFFFF}�������������, ������ ����� ���� �� ������ ������ /aedit ������� �������������, ����� ������������� ����������.
{FFD700}� {FFFFFF}������������� ������ � ������� ������� ������� � ������ �� �������, ���� �����.
{FF0000}* {FFFFFF}����� ������� ����� � ������� {228b22}FAQ{FFFFFF}, �� ������.
{FF0000}* {FFFFFF}�������������� ����������� ����������� ������� ����:
- ����������� - �������: 11:00 > 22:00.
- ������� - �����������: 09:00 > 22:30. ���������: �������.

{FFD700}������� ������������� �� �������:
{FFFFFF}�������������� �����������:
������� ������������� �� �������:
{6495ED}� {FFFFFF}�����������, ���������� ������, ����� �������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ������� ���� ��������, �������� ���� ����� (FD).
���������: �� ���������� ��. �������������.
{6495ED}� {FFFFFF}�������������� ����������� ��������, ������� ����-���� �������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ������ � /o, /aad ����������, �� ������� �����.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� "����������" ���������� (/aedit), ���� ��� �� ���� ��������� �� ���������.
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� ������������� ���������� (/aedit), ���� �� �� ���� ���� � ������� �������������.
���������: 2 �������.
{6495ED}� {FFFFFF}�������������� ����������� ���������� ������� � Non-RP ������ (/uval ���� �� �������).
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ����� ��� ���� �� �������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ����� � �����. ����.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ������������ ������ �� 4 ������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ���������� ������� �������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ���������� �����-����������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ��������� �� ������ ���������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ������� �������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� �������������� ���� �� �������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� � ��� ����� 50-�� �����.
���������: �������.
{6495ED}� {FFFFFF}�������������� (�� ��������� ���+) ����������� ������ � ��� ����� 30 �����.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ������� Nick_Name ����, ��� ��� � �����, � ��� �� �� ����������� ������� �������������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� �� ����� ������/�������������� �� ������ �������.
���������: ������ + ������ ������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� ���� �������.
���������: ������ + ���������� �������� + ������ ������.
{6495ED}� {FFFFFF}�������������� ����������� ����������������� � �������� ������� �������������(����������, ��, ���), ��� �� ����������.
 ���������: �������
{6495ED}� {FFFFFF}�������������� ����������� ����������� ���-���� � ������� �������������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� �� ����� ��������� �/�.
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� ViP ��������� �� �����.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ������ ��� ��� ������ ������� �������������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ������ 3-�� ������� ������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ����� ��������� ������/�������������� � ������������ ��������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� �������� �� ������ � ���-���� (�����������).
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ������� ������ (��������� � ����/����������������� � ����/� ���� ��� �������/��������).
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ���������� ������-���� ���������.
���������: ������� �������, ������� �� ��, 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ���� ����������� �������� ���������, �� �������� 21 ����.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ����������� ���� �������, �� ��������������� ����� ���������.
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� ����������� ������� ��������������, �� ��������������� ��� ���������.
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� �������� �������, ��� ���������� ������� ������������� (�� ���).
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ��������� ������ � �������� "1", "����������", "bb" � ���-�� �� ������� �����.
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� ����� ������.
���������: �������.
{FF0000}� {FFFFFF}�������������� ����������� ����� ���: � �. ���-������, ������� ������� Green Town.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ����������� � RolePlay �������. ���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� �� ����� ������ ���������(�������).
����������: �������� �� �������� ���������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ����� �����. ���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ������������ ���� CJ [!] ����������: ������� �������������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� � ��-���� �� ����� �������� ���.
���������: 2 ��������
{6495ED}� {FFFFFF}�������������� ����������� ������������� � ��������� ����� ������������ ������� (���.�������, �������, �����, �����).
���������: 2 ��������
{6495ED}� {FFFFFF}�������������� ����������� ���������� �����-���� ������ ��������� �����(/pm , /a, /sms � �.�).
���������: 2 ��������
{6495ED}� {FFFFFF}������������� ��������� ����������� � ������������ � �������� �����-���� ����� � ���.
���������: �������(����������: ���������� �� ������� �������������)
{6495ED}� {FFFFFF}������������� ����������� �������� ������� ��� �������.
���������: �������
{6495ED}� {FFFFFF}������������� ����������� ������� "��" �������� ���������� ��� ���������� ��������.
���������: �������
{6495ED}� {FFFFFF}�������������� ����������� �������� � ����� ������� "������ �� ���������������",
���� ������ ���������� �� ������� ��������������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� �������������� ����������� ������� (/ucc,/slp, /crash).
���������: 2 ��������
{6495ED}� {FFFFFF}�������������� ����������� ����������������� � ������� ������������� ��� ����������.
���������: �������
{6495ED}� {FFFFFF}�������������� ����������� ��������������� � ���� ������� �������������.
���������: �������
{6495ED}� {FFFFFF}�������������� ����������� ��������������� � ���� ������ ��� ������� ������.
���������: �������
{6495ED}� {FFFFFF}�������������� ����������� �������/�������� ������� �������������� ��� �������.
���������: �������
{6495ED}� {FFFFFF}�������������� ����������� ������������ ������� /skick,/kick � ������ �����.
���������: �������
{6495ED}� {FFFFFF}�������������� ����������� ������/�������/������ ������� �������������� �� ������ ���������.
���������: �������/������
{6495ED}� {FFFFFF}�������������� ����������� ������������� ������� ��������������/������.
���������: �������
{6495ED}� {FFFFFF}�������������� ����������� ��������� ���� ����������.
���������: 2 ��������
{6495ED}� {FFFFFF}�������������� ����������� ����� ���� ����������� � ����� �� ������(�������, ����������, ����� ���� �����������).
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� ������������� �������� � �������� �� ������ (�� ���������, �� ����������).
���������: �������������� �� �������� ������� � �������.
{6495ED}� {FFFFFF}�������������� ����������� ���������� ����������� ������ � /a.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� �������� ���� ����������� ������ ������ ���������(������� ����).
{6495ED}� {FFFFFF}�������������� ����������� ������������ ��������� ��������� �� ������� � ��������,
����������� � ׸���� ������ ������� (����. ����, �� ���������� ������� Luxwen Role Play, ������).
���������: ������ (�������� �� �������).
{6495ED}� {FFFFFF}�������������� ����������� ������ ����� �� ������ �����������.
���������: �������.
{6495ED}� {FFFFFF}�������������� ����������� ����� ������������� �� �������.
���������: ������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� �������/����������� � ������� �������.
���������: 2 ��������.
{6495ED}� {FFFFFF}�������������� ����������� ��������� �������� ������� �������������.
���������: �� ����������.
]], "{FFFFFF}�������", "", 5)
    end)
sampRegisterChatCommand("predit", function()
        sampShowDialog(1, " ", [[
{00FA9A}I. �������� �������.
{00FA9A}1.1. {FFFFFF}�������� ������ �� ����������� �� ���������������.
{00FA9A}1.2. {FFFFFF}� ������ ������������� ����������, �� ������ ���� ��-����������.
{00FA9A}1.3. {FFFFFF}���������� �� ������ ������������.
{00FA9A}1.4. {FFFFFF}��� �������� �����, �������: ���.; ���.; ����. Luxwen-�����: �����. (1� - ���., 1�� - ���., 1��� - ����.).
{FFD700}������: {FFFFFF}����� ��� � ����� ����� �����. ������: 100 ���. ����.
{FFD700}������: {FFFFFF}������ ��� � �. ���-������. ����: 3 ������.
{00FA9A}1.5. {FFFFFF}��������� ������������ ������� ���������� (HTML �����).

{FF69B4}II. {FFFFFF}������� ��������������.
{FF69B4}2.1. {FFFFFF}���������� ���������� �� ������ ���� ��������, � ��������������� �� ��������.
{FF69B4}2.2. {FFFFFF}������ ������� �� ������� �����, �������� ������������ ������� - �� ���������� �����.
{FF69B4}2.3. {FFFFFF}���������� �� ������ ���� ��������������� � ��������.
{FF69B4}2.4. {FFFFFF}� �������� ������������ �������, ������������ ������� (").

{9acd32}III. {FFFFFF}������� �����/������� �������.
{9acd32}3.1. {FFFFFF}��� ������� ����-����, �������: ������: �����. (���� ������ �� ������, �� ������: ���������).
{9acd32}3.2. {FFFFFF}��� ������� ����-����, ������� ����: �����. (���� ���� �� �������, �� ����: ����������).
{9acd32}3.3. {FFFFFF}��� �������/������� ������������, ����������� ������ ���� ��������������.
{9acd32}3.4. {FFFFFF}��� �������/������� �������, ����������� ������ ���� �������� ������� � ��� ������������.
{9acd32}3.5. {FFFFFF}��� �������/������� ������������� ��������, ����������� ������ ���� �����.
(���� �� �������, ��: �/� - ����������, �/� - ��������, �/� - �������, �/� - ������, �/� - ������������ ��������).
{9acd32}3.6. {FFFFFF}���� ��� ������� ������������, �������, �� ������� ��� ��������������, �� �������: � ����� ����� �����.

{32CD32}IV. {FFFFFF}������ ����.
{32CD32}4.1. {FFFFFF}����� - ������� �����.
{32CD32}4.2. {FFFFFF}GPS - ���������.
{32CD32}4.3. {FFFFFF}���� ID - ������ �� ������.
{32CD32}4.4. {FFFFFF}C��� - ������.
{32CD32}4.5. {FFFFFF}����������� - �������.

{ADFF2F}V. {FFFFFF}������ � �������, �������.
{ADFF2F}5.1. ������ ����������� �� "�.".
{ADFF2F}5.2. ������� ����������� �� "�.".
{ADFF2F}5.3. ���� �� �����������.
{ADFF2F}5.4. ������ ����������� �� "�."
{FFD700}�������� �������, ��������, ��������:
{ADFF2F}�. {FFFFFF}���-������.
{ADFF2F}�. {FFFFFF}���-������.
{ADFF2F}�. {FFFFFF}���-��������.
{ADFF2F}���� {FFFFFF}VineWood.
{ADFF2F}�. {FFFFFF}��������-����.
{ADFF2F}�. {FFFFFF}��������.
{ADFF2F}�. {FFFFFF}����������.
{ADFF2F}�. {FFFFFF}����-������
{ADFF2F}�. {FFFFFF}����������.
{ADFF2F}�. {FFFFFF}Family.

{FF1493}VI. {FFFFFF}����������.
{FF1493}6.1.{FFFFFF} �/� - ����������.
{FF1493}6.2. {FFFFFF}�/� - ��������.
{FF1493}6.3. {FFFFFF}�/� - ������.
{FF1493}6.4.{FFFFFF} �/� - �������.
{FF1493}6.5. {FFFFFF}�/� - ���������.

{F4A460}VII. {FFFFFF}�������������.
{F4A460}7.1. {FFFFFF}� ���. ������� �� ������������� ����������.
{F4A460}7.2. {FFFFFF}������������� ��� ����:
{FFFFFF}�������� ������������� � ���������� ���� - East Side Ballas/Los Santos Vagos/West Side Grove/Varrios Los Aztecas/East Coast Rifa, ������� �� �����.
{F4A460}7.3. {FFFFFF}������������� ��� �����:
{FFFFFF}�������� ������������� � �����-����/��������/��� "La Cosa Nostra/Yakuza/Russian Mafia", ������� �� ����.
{FFFFFF}�������� ������������� � ���������� ��������� "Hitmans", ������� �� ����.

{DC143C}VIII. {FFFFFF}����� �����.
{DC143C}8.1. {FFFFFF}����� ����� ��������.
{FFD700}������: {FFFFFF}����� "�����" ���� ������� �������������. ������� ���������.
{DC143C}8.2. {FFFFFF}����� ����� ��������.
������: {FFFFFF}��� �������� ��� ������ "Nick Name". ������� ���������.

{FF0000}��� ������� ��������������:
{FFFFFF}����� ��� � ������� ������. ������: 2 ���. ����.
�������� ������������� � ���������� ���� ''Varrios Los Aztecas''. ���������: 1-1.
������ ������ ��� ������: "186". ����: ����������.
����� ������ "Woo Zie Mu", ������: ���������.
����� ������� "�������". ������: ���������.

����� ��� � �. ���-������. ������: ���������.
����� �/� ����� "Infernus". ������: 500 ���. ����.
����� �/� "���" � ����� ����� �����. ������: 2 ����. ����.
������ �/� "24/7" � �. ���-������. ����: 900 ���. ����.
������ �/� ����� "Maverick". ����: 180 ���. ����.
����� ��� � �. ����������. ������: 30 ����. ����.
��� �������������� ViP ����������:
����� �/� ViP ������ "����������� + �������� ������". ������: ���������.
������ �/� ViP ������ "Turismo Cute Snowman". ����: ����������.]], "{FFFFFF}�������", "", 4)
    end)
sampRegisterChatCommand("gheto", function()
        sampShowDialog(1, "{FFF000}������� ����� �� �����������", [[
{FFD700}�������� �������:
{FFD700}1.1. {FFFFFF}�������� ������ �� ����������� ��� �� ���������������;
{FFD700}1.2. {FFFFFF}��� ����� �� ���������� ��������� 2 ��������;
{FFD700}1.3. {FFFFFF}����� �� ���������� ���������� � 12:00 �� 23:00 �� ���;
{FFD700}1.4. {FFFFFF}�� ��������� ������ ���������� ����� �� ����������, ����������� ������, ���, warn, ���;
{FFD700}1.5. {FFFFFF}���� ����� ���������� ����������� �� ������� ���� ���� - 14 ����, �� ��� ������� ���������������;
{FFD700}1.6. {FFFFFF}������ �� ������� ���������� � ������ "������ �� ��������";
{FFD700}1.7. {FFFFFF}��������� 3 �������������� �� ����� ����� (0/3);
{FFD700}1.8. {FFFFFF}����� �� ���������� ������ �� ����� �����, �� ������� ����� ��������� ���� �������� ���������;
{FFD700}1.9. {FFFFFF}��������� ������ � ����� �� "Android".

{228B22}2. ��������� �� ����� ���������� ����� �� ����������:
{228B22}2.1. {FFFFFF}��������� ������������ ������, ������� ���� � /get guns;
{228B22}2.2. {FFFFFF}��������� ������������ �������, ���������;
{228B22}2.3. {FFFFFF}��������� ������������ ���� ��������;
{228B22}2.4. {FFFFFF}��������� ������� ������, ������� ������ ������ �� �����;
{228B22}2.5.{FFFFFF} ��������� ������������ ������������ ������� (������ �4, � � ������������ ��������);
{228B22}2.6. {FFFFFF}��������� ������������ ����� ������ � 1 ������, ��� ������ ���������� � ������ ���������.

{FF0000}3. ��������� �� ����� ���������� ����� �� ����������:
{FF0000}3.1.1. {FFFFFF}����.
���������: ������ �� 180 �����, warn, -2 ����������;
{FF0000}3.1.2. {FFFFFF}���� �� 6 �����.
���������: ������ �� 180 �����, warn, 1/3;
{FF0000}3.1.3. {FFFFFF}���� �� 7+ �����.
���������: ������ �� 180 �����, warn, -2 ����������;
{FF0000}3.1.4. {FFFFFF}����� �� �������� �� 6 �����.
���������: ������ �� 180 �����, warn, 1/3;
{FF0000}3.1.5. {FFFFFF}����� �� �������� �� 7+ �����.
���������: ������ �� 180 �����, warn, -2 ����������;
{FF0000}3.2. {FFFFFF}���� ������ ����� ��������.
���������: ������ 60 ����� � 1/3;
{FF0000}3.3. {FFFFFF}����� ������ �����.
���������: ������ � ��������� ����� ���������������, 1/3;
{FF0000}3.4. {FFFFFF}�������� ������� � ������ (2 ��������).
���������: warn �� ��, -1 ����������;
{FF0000}3.5. {FFFFFF}Spawn Kill. ���������: warn, -1 ����������;
{FF0000}3.6. {FFFFFF}������� �� ����� �� ���������� � ������ 150+.
���������: ���;
{FF0000}3.7. {FFFFFF}���� �� DM ���� � ������� ������� ������� � ���������
���������: ������ 30 �����, 1/3;
{FF0000}3.8. {FFFFFF}����� ���� "�����" � ������ ������ � ��������.
���������: BanIP, � ���-�� ����������� ����������;
{FF0000}3.9. {FFFFFF}������� ������� � �����/�������/��������.
���������: ������ �� 45 �����, 1/3;
{FF0000}3.10. {FFFFFF}���������� �� ��������������� �������������.
���������: ������ �� 25 �����, 1/3;
{FF0000}3.11. {FFFFFF}���� ���� (�� ���� ����� ����, ����� �� ����������� ��������).
���������: ������ 30 �����, 1/3.
{FF0000}3.12. {FFFFFF}���� �� ��������� (����� � ����, ����� �������� �������).
���������: ������ �� 30 �����, 1/3;
{FF0000}3.13. {FFFFFF}AFK ������ 30 ������.
���������: ������ 10 �����, 1/3;
{FF0000}3.14. {FFFFFF}��������� ������� ����� � ���� �� ��������� �����.
���������: ��� ���������� �� 60 �����, ������ - �������;
{FF0000}3.15. {FFFFFF}������ �� ����� �� �����������/������ ������ ���������� �����������. ���������: ������ �� 30 �����;
{FF0000}3.16. {FFFFFF}����: ������� ��� �� ������� �����, ������� ������ �� ����������.
������ �� ��. �������, ��� ������ - warn;
{FF0000}3.17. {FFFFFF}���� �������/������/�����.
���������: -2 ����������. (-3, ���� 1 ���������� ���� ��������� - ������������);
{FF0000}3.18. {FFFFFF}������������� ���������� ����� ����� �� ����� ����.
���������: ������ �� 25 �����, 1/3;
{FF0000}3.19. {FFFFFF}���������� �� �����.
���������: ������, ������� ������ - �����������, ����� - �������, 1/3;
{FF0000}3.20. {FFFFFF}������.
{FFFFFF}���������:3 (7) ������ - 1/3, 6 (3) ������ - 2/3, ����� ����� (0:01) - ����� �������, ������� ������� �������
{FF0000}3.21. {FFFFFF}���� ���������� �� ����� �����. ���������: ������ ����� �������, �� �����.

{FFA500}4. ������� �������� ���� �� ������:
{FFA500}4.1. {FFFFFF}��������� ������� ��� � �������� (��� ������ ��������� �� 2�� �� �� �����).
{FFFFFF}���������: 1 ��� - �������������� � ������������, ����� - ������ �� 15 �����, 1/3;
{FFA500}4.2. {FFFFFF}������� ��� � ��������, � ������� ������ �����.
���������: ������ 15 �����, 1/3;
{FFA500}4.3. {FFFFFF}������� ��������� ��� ����� � ��������� ��������.
���������: ������ �� 15 �����, 1/3.

{B22222}5. ������� ����������:
{B22222}5.1. {FFFFFF}����.
���������: -2 ����������;
{B22222}5.1.1. {FFFFFF}���� �� 6 �����.
���������: ������ �� 180 �����, warn, 1/3;
{B22222}5.1.2. {FFFFFF}���� �� 7+ �����.
���������: ������ �� 180 �����, warn, -2 ����������;
{B22222}5.2. {FFFFFF}�� ������������� ����� ��������.
���������: jail 60 min , 1/3;
{B22222}5.3. {FFFFFF}�� �������� ������� � ������ (2 ��������).
���������: -1 ����������;
{B22222}5.4. {FFFFFF}�� �������� ��: ������� � ����� ����, ������ ����.
���������: -3 ����������;
{B22222}5.5. {FFFFFF}�� ���� �������/������/�����.
���������: -4 ����������. (-5, ���� ���������� ���� ��������� - ������������);
{B22222}5.6. {FFFFFF}�� ������ �� ����������.
���������: 3 ������ - 1/3, 6 ������ - 2/3, ����� ����� - ����������
������� �����, ������� ������� 2-�� �����;
{B22222}5.7. {FFFFFF}����� �� ��������.
���������: -2 ����������;

{00FFFF}6. �����:
{00FFFF}6.1. {FFFFFF}����� ����� ����� ����� ����� ����� 2 ���� (2 ��� ����� ����� ������ �������� ������);
{00FFFF}6.2. {FFFFFF}����� ����� ����� ����� ����� �� 6 �����;
{00FFFF}6.3. {FFFFFF}����� ����� ��� ������������� ����� ���������� �� ������, �� ����� ��� ����� �����, ����� ��� �� �����������;
{00FFFF}6.4. {FFFFFF}�� ������ ������ ������ ���� ������������ ������� (��� ������� - �� �����������).
]], "{FFFFFF}�������", "", 4)
    end)
sampRegisterChatCommand("html", function()
        sampShowDialog(5, "{FFF000}HTML-�����", [[
 {FFFFFF}������� �����:
{CD5C5C} Test � {FFFFFF}CD5C5C
{F08080} Test - {FFFFFF}F08080
{FA8072} Test - {FFFFFF}FA8072
{E9967A} Test - {FFFFFF}E9967A
{FFA07A} Test - {FFFFFF}FFA07A
{DC143C} Test - {FFFFFF}DC143C
{FF0000} Test - {FFFFFF}FF0000
{B22222} Test - {FFFFFF}B22222
{8B0000} Test - {FFFFFF}8B0000

 ������� �����:
{FFC0CB} Test - {FFFFFF}FFC0CB
{FFB6C1} Test - {FFFFFF}FFB6C1
{FF69B4} Test - {FFFFFF}FF69B4
{FF1493} Test - {FFFFFF}FF1493
{C71585} Test - {FFFFFF}C71585
{DB7093} Test - {FFFFFF}DB7093

 ��������� �����:
{FFA07A} Test - {FFFFFF}FFA07A
{FF7F50} Test - {FFFFFF}FF7F50
{FF6347} Test - {FFFFFF}FF6347
{FF4500} Test - {FFFFFF}FF4500
{FF8C00} Test - {FFFFFF}FF8C00
{FFA500} Test - {FFFFFF}FFA500

 Ƹ���� �����:
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

 ���������� �����:
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

 ���������� �����:
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

 ������ �����:
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

 ����� �����:
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

 ����� �����:
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

 ����� �����:
{DCDCDC} Test - {FFFFFF}DCDCDC
{D3D3D3} Test - {FFFFFF}D3D3D3
{C0C0C0} Test - {FFFFFF}C0C0C0
{A9A9A9} Test - {FFFFFF}A9A9A9
{808080} Test - {FFFFFF}808080
{696969} Test - {FFFFFF}696969
{778899} Test - {FFFFFF}778899
{708090} Test - {FFFFFF}708090
{2F4F4F} Test - {FFFFFF}2F4F4F

]], "{FFFFFF}�������", "", 5)
    end)
sampRegisterChatCommand("emc", function()
        sampShowDialog(5, " ", [[
{FFFFFF}���������: {9ACD32}PREMIUM HELPER
{FFFFFF}���������: {9ACD32}1 ���������� �����
������� ������ � {9acd32}vk.com/obikenobii


{FF6347}������������ PREMIUM �������
{FFFFFF}1)PREMIUM ������ �� ����� ���������� ( {c1cc2b}�������������� ���� �������� {FFFFFF})
{FFFFFF}2)�� ��������� �������� �� ��������� ���. ����������
3)��� ������� ���� � Discord ������� Luxwen Role Play: {FF0000}������������ ��������
{FFFFFF}4)�� ������� ���������� ���� ����������� �� ��������� ������� � �������!
{FFFFFF}5)����������� ������ ��������� ������� � �������� ��4! (���������: /howfd)
]], "{FFFFFF}�������", "������", 0)
    end)
sampRegisterChatCommand("howfd", function()
        sampShowDialog(5, " ", [[
{FFFFFF}����� �������� ��������� Full Dostup 4 ������ *({FF0000}��������{FFFFFF}), ����������:
{ee7c00}� {FFFFFF}�������� �� 10000 ��������.
{ee7c00}� {FFFFFF}������������� 2000 �������.
{ee7c00}� {FFFFFF}�������� � ������ 2000 �������.
{ee7c00}� {FFFFFF}������ ���������� ���� 1500 �������.
]], "{FFFFFF}�������", "������", 0)
    end)
    for k, v in pairs(pm) do
        sampRegisterChatCommand(""..k, function(id)
            if tonumber(id) ~= nil then
                if sampIsPlayerConnected(tonumber(id)) then
                    sampSendChat("/pm "..id.." "..v)
                else
                    sampAddChatMessage("{FF6347}[������] {FFFFFF}�� ������� ���� ID/����� offline!", -1)
                end
            else
                sampAddChatMessage("{FF6347}[������] {FFFFFF}�������: {FFFFFF}/"..k.." [ID].", -1)
            end
        end)
    end
    wait(-1)
end
