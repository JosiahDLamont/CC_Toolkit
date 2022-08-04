local Menu = {}

--builds a menu
function new_menu()
    menu = {}
    menu.buttons = {}
    menu.marker_index = 1

    setmetatable(menu, Menu)
    return menu
end

--adds a new button to buttons
function Menu.new_button(self, display_name, callback)
    b = { text=display_name, func=callback }
    table.insert(self.buttons, b)
end

-- this function activates the button located at index, if it exists and has a function
function Menu.select_button(self, index)
    if self.buttons[index] == nil then
        return
    elseif self.buttons[index].func == nil then
        return
    else
        self.buttons[index].func()
    end
end

--parses key input to navigate the menu
function Menu.parse_key(self)

    num_buttons = table.getn(self.buttons)
    local event, key = os.pullEvent("key")
    if key == keys.up then
        self.marker_index = self.marker_index - 1
    elseif key == keys.down then
        self.marker_index = self.marker_index + 1
    elseif key == keys.enter then
        self:select_button(self.marker_index)
    end

    if self.marker_index < 1 then
        self.marker_index = self.marker_index + num_buttons
    elseif self.marker_index > num_buttons then
        self.marker_index = self.marker_index - num_buttons
    end

end

--prints the buttons to the terminal without clearing it first
function Menu.print_buttons(self)
    local marker = "ERR"
    for num, button in pairs(self.buttons) do

        if marker_index == num then
            marker = "["..num.."]"
        else
            marker = " "..num.." "
        end

        print(marker .. "\t" .. button.text)
    end
end

return Menu
