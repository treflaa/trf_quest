trfConfig = {}

-- [LOCATII]
trfConfig.position = vector3(-529.99768066406,-229.85382080078,36.702110290527); -- Coordonatele sacului
trfConfig.places = { -- Casele unde poti colinda
    {946.7216796875,-518.40380859375,60.625503540039},
    {1221.3104248047,-668.30670166016,63.493137359619},
    {1265.6435546875,-648.07092285156,67.921478271484},
    {-1122.9327392578,484.40148925781,82.160774230957},
    {-1257.8372802734,447.68292236328,94.73558807373},
    {-1450.9282226562,545.13006591797,120.79932403564},
    {-867.54235839844,786.12707519531,191.93426513672},
    {-400.13223266602,665.54052734375,163.83015441895},
    {118.47206115723,493.30285644531,147.34295654297},
    {480.38677978516,-1736.9958496094,29.151020050049},
    {252.61637878418,-1672.0622558594,29.663167953491},
    {129.88659667969,-1854.4306640625,24.899221420288},
    {56.570770263672,-1921.4671630859,21.710613250732},
    {-32.831237792969,-1847.2816162109,26.19352722168},
    {-14.126574516296,-1442.9577636719,31.099449157715},
    {1301.2875976562,-573.3759765625,71.732231140137}
}

-- [REWARDS]
trfConfig.bombaneMax = 150; -- Cate bomboane trebuie ca sa se umple sacul
trfConfig.rewardBomboane = math.random(1,3); -- Cate bomboane sa primeasca pe colind
trfConfig.rewardBani = math.random(50000,70000); -- Cati bani primeste dupa ce a umplut sacul si l-a collectat

-- [ITEM]
trfConfig.itemCod = "bomboane"; -- Codul item-ului pe care sa il primeasca la colind si cu care sa umple sacul
trfConfig.itemName = "Bomboane"; -- Numele item-ului pe care sa il primeasca la colind si cu care sa umple sacul
trfConfig.itemDescription = "Umple sacul de la primarie cu bomboanele"; -- Descrierea item-ului pe care sa il primeasca la colind si cu care sa umple sacul
trfConfig.itemHeight = 0.1; -- Greutatea item-ului pe care sa il primeasca la colind si cu care sa umple sacul

-- [PED]
trfConfig.ped = "a_m_y_busicas_01"; -- Ped-ul care se spawneaza cand colinzi

-- [COMENZI]
trfConfig.comandaPack = "pack"; -- Comanda de a pune in sac
trfConfig.comandaCollect = "collect"; -- Comanda de a colecta sacul
trfConfig.comandaQuest = "quest"; -- Comanda care porneste quest-ul
trfConfig.comandaQuestoff = "questoff"; -- Comanda care iti da urmatoarea misiunea

-- [BLIP]
trfConfig.blipScale = 0.7; -- Marimea blip-ului
trfConfig.blipSprite = 417; -- Iconita blip-ului
trfConfig.blipColour = 1; -- Culoarea blip-ului
trfConfig.blipColourRoute = 1; -- Culoarea rutei pana la blip
trfConfig.blipRoute = true; -- true - daca vrei sa fie o ruta pana la blip ; false - daca vrei sa fie doar un blip pe harta fara ruta pana la el