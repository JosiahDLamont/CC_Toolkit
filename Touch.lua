
local function check_args()
    if (args == null) or (args[1] == null) then
        printError("Usage: touch <filename.extension>")
    end
end

local function check_duplicate_file(path)
    if fs.exists(path) then
        printError(args[1] .. " already exists!")
    end
end

local function check_success(path)
    if not fs.exists(path) then
        printfError("File not successfully created")
    end
end

local function main()

    check_args()
    local path = shell.resolve(args[1])
    check_duplicate_file(path)
    new_file = fs.open(path, "w")
    new_file.close()
    check_success(path)

end

args = {}
args[1] = ...
main()
