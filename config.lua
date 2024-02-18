Config = {}

Config.rewards = {'money'}
Config.whiteListItems = {
    oxy = {price = 50}, 
plastic = {price = 15}, 
medikit = {price = 25}, 
garbage = {price = 3},
}

Config.shopsTargets = {
    pawnshop = {
        --ped
        hash = 's_m_y_dealer_01',
        coords = vector3(150.916, -1033.239, 28.340),
        distance = 1.5,
        shops = 'Pawn Shop',
        icons = 'fa-solid fa-gun',
        --stash
        id    = 'pwnshop',
        slots = 5,
        weight = 100000,
        owner = false,
    },
    arena = {
        --ped
        hash = 's_m_y_dealer_01',
        coords = vector3(163.081, -1037.934, 28.313),
        distance = 1.5,
        shops = 'Arena Shop',
        icons = 'fa-solid fa-gun',
        --stash
        id    = 'arena',
        slots = 5,
        weight = 100000,
        owner = false,
    },
}
