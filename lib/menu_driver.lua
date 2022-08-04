Menu = require("Menu")

--clears the terminal
local function clear()
    term.clear()
    term.setCursorPos(1,1)
end

--placeholder callback function for testing
local function foobar()
    clear()
    print("Success!")
    os.sleep(.5)
end

--driver function to test functionality
local function driver()
    meta_commands = { should_exit=false, banner = "#### Banner ####" }
    menu = Menu
    menu:new_button("hi", foobar)
    menu:new_button("hey", function() meta_commands.banner = "???? Banner ????" end)
    menu:new_button("foo", function() meta_commands.banner = "<><> Banner <><>" end)
    menu:new_button("exit", function() meta_commands.should_exit = true end)

    while not meta_commands.should_exit do
        clear()
        print(meta_commands.banner)
        menu:print_buttons()
        menu:parse_key()
    end
    clear()
end

driver()
print("Program Terminated Successfully!")
