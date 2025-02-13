
local function check_args(args)
    if (args == null) or (args[1] == null) then
        printError("Usage: touch <filename.extension>")
				return false
    end
		return true
end

local function main(args)

    if not check_args(args) then
			return
    end
    local path = shell.resolve(args[1])

		if fs.exists(path) then
      printError(args[1] .. " already exists!")
			return
		end

    new_file = fs.open(path, "w")
    new_file.close()

		if not fs.exists(path) then
			printError("Not able to create file " .. args[1])
		end
end

local args = {...}
main(args)
