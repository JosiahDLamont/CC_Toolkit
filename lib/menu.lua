
local buttons = {}
local marker_index = 1

--adds a new button to buttons
local function new_button(display_name, callback)
    b = { text=display_name, func=callback }
    table.insert(buttons, b)
end

-- this function activates the button located at index, if it exists and has a function
local function select_button(index)
    if buttons[index] == nil then
        return
    elseif buttons[index].func == nil then
        return
    else
        buttons[index].func()
    end
end

--parses key input to navigate the menu
local function parse_key()

    num_buttons = table.getn(buttons)
    local event, key = os.pullEvent("key")
    if key == keys.up then
        marker_index = marker_index - 1
    elseif key == keys.down then
        marker_index = marker_index + 1
    elseif key == keys.enter then
        select_button(marker_index)
    end

    if marker_index < 1 then
        marker_index = marker_index + num_buttons
    elseif marker_index > num_buttons then
        marker_index = marker_index - num_buttons
    end

end

--prints the buttons to the terminal without clearing it first
local function print_buttons()
    local marker = "ERR"
    for num, button in pairs(buttons) do

        if marker_index == num then
            marker = "["..num.."]"
        else
            marker = " "..num.." "
        end

        print(marker .. "\t" .. button.text)
    end
end

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
    new_button("hi", foobar)
    new_button("hey", function() meta_commands.banner = "???? Banner ????" end)
    new_button("foo", function() meta_commands.banner = "<><> Banner <><>" end)
    new_button("exit", function() meta_commands.should_exit = true end)

    while not meta_commands.should_exit do

        clear()
        print(meta_commands.banner)
        print_buttons()
        parse_key()
    end
    clear()
end


driver()
print("Program Terminated Successfully!")
