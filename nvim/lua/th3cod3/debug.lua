_G.dump = function (...)
  local objects = vim.tbl_map(vim.inspect, { ... })

  local f = io.open("/tmp/nvim-th3cod3.log", "a")
  if not f then
    print("Couldn't open file")

    return
  end

  f:write("\n--------------------------------\n")
  for _, object in ipairs(objects) do
    f:write(object)
    f:write("\n############################\n")
  end
  f:write("\n--------------------------------\n")

  f:close()
end
