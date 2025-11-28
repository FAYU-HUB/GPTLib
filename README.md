# Make the Load

local GPTLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/FAYU-HUB/GPTLib/refs/heads/main/LoadGPTlib.lua"))()

# Make the Window

local Home = GPTLib:CreateTab("Home")

# Make the Button

Home:Button("Test Button", function()
    print("hello")
end)

# Make Switch

Home:Toggle("Power Switch", false, function(v)
    print("Toggle:", v)
end)

# Make Slider

Home:Slider("Speed", 1, 100, 20, function(v)
    print("Speed:", v)
end)

# Make DropDown

Home:Dropdown("Choose Item", {"Sword", "Gun", "Bow"}, function(v)
    print("idk:", v)
end)

# Make TextBox

Home:Textbox("Text", function(v)
    print("Textbox:", v)
end)

# Make Keybind

Home:Keybind("Jump Keybind", "F", function()
    print("Keybind")
end)
