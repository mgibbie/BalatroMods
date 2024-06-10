local jokers = {
    micatro_puck = {
        name = "micatro_puck", -- If I put "Seeing Double" here, Balatro is going to kill me
        slug = "micatro_puck",
        config = {},
        spritePos = {x = 0, y = 0},
        loc_txt = {
            name = "Puck",
            text = {
                "{C:attention,'Planet'}Planet Cards",
                "trigger twice."
            }
        },
        rarity = 2,
        cost = 5,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        functions = {
            loc_def = function(self)
                return {}
            end,
            calculate = function(self, context)
                -- Debug: Print when calculate is called
                print("calculate function called for joker: micatro_puck")
                return {}
            end
        }
    }
}

-- Debug: Print when jokers table is created
print("Jokers table created.")

-- Override the use_consumeable function for Card
local Card_use_consumeable_ref = Card.use_consumeable

function Card:use_consumeable(area, copier)
    -- Debug: Print when use_consumeable is called
    print("use_consumeable called on Card.")
    
    -- Debug: Print card details
    print("Card details: " .. tostring(self))
    
    -- Debug: Check if ability exists
    if self.ability then
        print("Card ability exists.")
        print("Card consumeable hand_type: " .. (self.ability.consumeable.hand_type or "nil"))
    else
        print("Card ability does not exist.")
    end

    -- Check if the card is a Planet card by checking its hand_type field
    if self.ability and self.ability.consumeable and self.ability.consumeable.hand_type then
        -- Debug: Print that a Planet card is detected
        print("Planet card detected.")
        
        -- Find the joker with name 'micatro_puck'
        local joker_list = find_joker('micatro_puck')
        local joker_number = #joker_list
        
        -- Debug: Print the number of jokers found
        print("Number of 'micatro_puck' jokers found: " .. joker_number)
        
        if joker_number > 0 then
            -- Trigger the planet card effect joker_number times
            print("Triggering Planet card due to 'micatro_puck' joker.")
            for i = 1, joker_number do
                print("Triggering Planet card - iteration: " .. i)
                Card_use_consumeable_ref(self, area, copier)
                -- Call update_hand_text to simulate the Planet card effect
                
                -- Debug: Print after calling the original function and update_hand_text
                print("Triggered Planet card - iteration: " .. i .. " completed.")
            end
        end
    end
    
    -- Trigger the original use_consumeable function
    print("Triggering original use_consumeable function.")
    Card_use_consumeable_ref(self, area, copier)
end

return jokers
