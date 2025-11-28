local Home = GPTLib:CreateTab("Home")

Home:Button("Test Button", function()
    print("Idk")
end)

Home:Toggle("Power Switch", false, function(v)
    print("Toggle:", v)
end)

Home:Slider("Speed", 1, 100, 20, function(v)
    print("Speed:", v)
end)

Home:Dropdown("Choose Item", {"Sword", "Gun", "Bow"}, function(v)
    print("idk:", v)
end)

Home:Textbox("Ketik di sini", function(v)
    print("Textbox:", v)
end)

Home:Keybind("Jump Keybind", "F", function()
    print("men")
end)
