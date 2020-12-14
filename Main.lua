--Credit me or I will ruin you
local lib = {}

local UserInputService = game:GetService("UserInputService")

lib.BindKeycode = Enum.KeyCode.Insert
lib.MainGUIInstance = nil
lib.CurrentMainObject = nil
lib.CurrentSectionHolder = nil
lib.CurrentSection = nil
lib.CurrentSectionInstance = nil
lib.CurrentlySelectedSection = nil
lib.Sections = {}
lib.CurrentSectionNumber = 0
lib.Focused = false
lib.KeyBinds = {}

function lib:CreateGui(ProductTextInput)
	local ScreenGui = Instance.new("ScreenGui")
	local Frame = Instance.new("Frame")
	local ProductText = Instance.new("TextLabel")

	ScreenGui.Parent = game.CoreGui
	ScreenGui.ResetOnSpawn = false

	Frame.Parent = ScreenGui
	Frame.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
	Frame.BackgroundTransparency = 1
	Frame.BorderSizePixel = 2
	Frame.Position = UDim2.new(0.0092449775, 0, 0.0393120013, 0)
	Frame.Size = UDim2.new(0.0762711838, 0, 0.43857491, 0)
	Frame.ZIndex = 10

	ProductText.Name = "ProductText"
	ProductText.Parent = Frame
	ProductText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ProductText.BackgroundTransparency = 1.000
	ProductText.BorderSizePixel = 0
	ProductText.Position = UDim2.new(3.85322956e-08, 0, 0, 0)
	ProductText.Size = UDim2.new(1, 0, 0.0588235334, 0)
	ProductText.ZIndex = 11
	ProductText.Font = Enum.Font.SourceSans
	ProductText.Text = ProductTextInput
	ProductText.TextColor3 = Color3.fromRGB(255, 255, 255)
	ProductText.TextScaled = true
	ProductText.TextSize = 14.000
	ProductText.TextWrapped = true
	
	local MainGUI = Instance.new("Frame")

	MainGUI.Name = "MainGUI"
	MainGUI.Parent = Frame
	MainGUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainGUI.BackgroundTransparency = 1
	MainGUI.BorderSizePixel = 2
	MainGUI.Position = UDim2.new(0.0606060624, 0, 0.0588235296, 0)
	MainGUI.Size = UDim2.new(0.868686855, 0, 0.921568692, 0)
	MainGUI.ZIndex = 11
	
	lib.MainGUIInstance = Frame
	lib.CurrentMainObject = MainGUI
end

function lib:Bind(KeyCode)
	if KeyCode then
		lib.BindKeycode = KeyCode
	end
end

function lib:CreateSection(SectionName)
	local Section = {}
	
	Section.CurrentObject = nil
	Section.CurrentlySelectedObject = nil
	Section.Objects = {}
	Section.IObjects = {}
	Section.ButtonNumber = 0
	Section.Toggles = {}
	Section.Focused = false
	Section.KeybindBusy = nil
	
	--[[local SectionGUI = Instance.new("Frame")

	SectionGUI.Name = SectionName
	SectionGUI.Parent = lib.CurrentMainObject
	SectionGUI.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SectionGUI.BorderSizePixel = 2
	SectionGUI.Position = UDim2.new(0.0606060624, 0, 0.0588235296, 0)
	SectionGUI.Size = UDim2.new(0.868686855, 0, 0.921568692, 0)
	SectionGUI.ZIndex = 11]]
	
	local SectionButton = Instance.new("TextButton")

	SectionButton.Parent = lib.CurrentMainObject
	SectionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SectionButton.BorderSizePixel = 0
	SectionButton.BorderSizePixel = 0
	SectionButton.Size = UDim2.new(1, 0, 0.05, 0)
	SectionButton.ZIndex = 12
	SectionButton.Font = Enum.Font.SourceSans
	SectionButton.Text = SectionName
	SectionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	SectionButton.TextSize = 14.000
	SectionButton.AutoButtonColor = false
	
	if #lib.Sections <= 0 then
		SectionButton.Text = "> " .. SectionButton.Text
		lib.CurrentSectionNumber = 1
		lib.CurrentlySelectedSection = SectionButton
	end
	
	if lib.CurrentSectionInstance then
		SectionButton.Position = UDim2.new(0, 0, (lib.CurrentSectionInstance.Position.Y.Scale + lib.CurrentSectionInstance.Size.Y.Scale), 0)
	end
	
	table.insert(lib.Sections, #lib.Sections+1, {SectionButton, Section})
	
	lib.CurrentSection = Section
	lib.CurrentSectionInstance = SectionButton

	function Section:Button(ButtonText, CallBack)
		local CallBack = CallBack or function() end
		local TextButton = Instance.new("TextButton")
		
		TextButton.Text = ButtonText
		TextButton.Parent = lib.MainGUIInstance
		TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.BorderSizePixel = 0
		TextButton.Size = UDim2.new(1, 0, 0.05, 0)
		TextButton.ZIndex = 12
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 14.000
		TextButton.Visible = false
		TextButton.AutoButtonColor = false
		if Section.CurrentObject then
			TextButton.Position = UDim2.new(1.1, 0, (Section.CurrentObject.Position.Y.Scale + Section.CurrentObject.Size.Y.Scale), 0)
		else
			TextButton.Position = UDim2.new(1.1, 0, 0.05, 0)
		end
		
		if #Section.IObjects <= 0 then
			Section.CurrentlySelectedObject = TextButton
			Section.CurrentlySelectedObject.Text = "> " .. Section.CurrentlySelectedObject.Text
			Section.ButtonNumber = 1
		end
		
		table.insert(Section.IObjects, #Section.IObjects+1, {TextButton, CallBack})
		table.insert(Section.Objects, #Section.Objects+1, TextButton)
		Section.CurrentObject = TextButton
	end
	
	function Section:Toggle(ToggleText, CallBack)
		local CallBack = CallBack or function() end
		local TextButton = Instance.new("TextButton")

		TextButton.Text = ToggleText .. " [OFF]"
		TextButton.Parent = lib.MainGUIInstance
		TextButton.BorderSizePixel = 0
		TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.Size = UDim2.new(1, 0, 0.05, 0)
		TextButton.ZIndex = 12
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 14.000
		TextButton.Visible = false
		TextButton.AutoButtonColor = false
		if Section.CurrentObject then
			TextButton.Position = UDim2.new(1.1, 0, (Section.CurrentObject.Position.Y.Scale + Section.CurrentObject.Size.Y.Scale), 0)
		else
			TextButton.Position = UDim2.new(1.1, 0, 0.05, 0)
		end

		if #Section.IObjects <= 0 then
			Section.CurrentlySelectedObject = TextButton
			Section.CurrentlySelectedObject.Text = "> " .. Section.CurrentlySelectedObject.Text
			Section.ButtonNumber = 1
		end
		
		table.insert(Section.Objects, #Section.Objects+1, TextButton)
		table.insert(Section.IObjects, #Section.IObjects+1, {TextButton, CallBack})
		table.insert(Section.Toggles, #Section.Toggles+1, {TextButton, CallBack, false})
		Section.CurrentObject = TextButton
	end
	
	function Section:Input(InputText, StartingValue, CallBack)
		local CallBack = CallBack or function() end
		local TextButton = Instance.new("TextButton")

		TextButton.Text = InputText .. " < ".. tostring(StartingValue) .." >"
		TextButton.Parent = lib.MainGUIInstance
		TextButton.BorderSizePixel = 0
		TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.Size = UDim2.new(1, 0, 0.05, 0)
		TextButton.ZIndex = 12
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 14.000
		TextButton.Visible = false
		TextButton.AutoButtonColor = false
		if Section.CurrentObject then
			TextButton.Position = UDim2.new(1.1, 0, (Section.CurrentObject.Position.Y.Scale + Section.CurrentObject.Size.Y.Scale), 0)
		else
			TextButton.Position = UDim2.new(1.1, 0, 0.05, 0)
		end

		if #Section.IObjects <= 0 then
			Section.CurrentlySelectedObject = TextButton
			Section.CurrentlySelectedObject.Text = "> " .. Section.CurrentlySelectedObject.Text
			Section.ButtonNumber = 1
		end
		
		local ReceiveFunction = function()
			Section.Focused = true
			local Found = false
			for i,v in pairs(Section.IObjects) do
				if v[1] == TextButton then
					Found = true
					TextButton.Text = "> " .. InputText .. " < " .. tostring(v[3]) .. " >"
					CallBack(v[3])
					break
				end
			end
			if not Found then
				TextButton.Text = "> " .. InputText .. " < " .. StartingValue .. " >"
				CallBack(StartingValue)
			end
		end
		
		table.insert(Section.Objects, #Section.Objects+1, TextButton)
		table.insert(Section.IObjects, #Section.IObjects+1, {TextButton, ReceiveFunction, StartingValue})
		Section.CurrentObject = TextButton
	end
	
	function Section:Keybind(Text, CallBack)
		local CallBack = CallBack or function() end
		local TextButton = Instance.new("TextButton")

		TextButton.Text = Text .. " <NO KEY ASSIGNED>"
		TextButton.Parent = lib.MainGUIInstance
		TextButton.BorderSizePixel = 0
		TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.Size = UDim2.new(1, 0, 0.05, 0)
		TextButton.ZIndex = 12
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 14.000
		TextButton.Visible = false
		TextButton.AutoButtonColor = false
		if Section.CurrentObject then
			TextButton.Position = UDim2.new(1.1, 0, (Section.CurrentObject.Position.Y.Scale + Section.CurrentObject.Size.Y.Scale), 0)
		else
			TextButton.Position = UDim2.new(1.1, 0, 0.05, 0)
		end

		if #Section.IObjects <= 0 then
			Section.CurrentlySelectedObject = TextButton
			Section.CurrentlySelectedObject.Text = "> " .. Section.CurrentlySelectedObject.Text
			Section.ButtonNumber = 1
		end

		local ReceiveFunction = function(IsDown)
			local Found = false
			for i,v in pairs(lib.KeyBinds) do
				if v[3] == TextButton then
					v = nil
					table.remove(lib.KeyBinds, i)
					break
				end
			end
			for i,v in pairs(Section.IObjects) do
				if v[1] == TextButton and v[3] then
					print(tostring(v[3]))
					Found = true
					TextButton.Text = "> " .. Text .. " <" .. tostring(v[3].Name) .. ">"
					if v[3] == "LMB" then
						TextButton.Text = "> " .. Text .. " <LMB>"
					elseif v[3] == "RMB" then
						TextButton.Text = "> " .. Text .. " <RMB>"
					elseif v[3] == "MMB" then
						TextButton.Text = "> " .. Text .. " <MMB>"
					end
					table.insert(lib.KeyBinds, #lib.KeyBinds+1, {v[3], CallBack, TextButton, IsDown})
					CallBack(IsDown)
					break
				end
			end
			if not Found then
				TextButton.Text = "> " .. Text .. " <NO KEY ASSIGNED>"
			end
			Section.KeybindBusy = false
		end

		table.insert(Section.Objects, #Section.Objects+1, TextButton)
		table.insert(Section.IObjects, #Section.IObjects+1, {TextButton, ReceiveFunction, Enum.KeyCode.Unknown, "Keybind"})
		Section.CurrentObject = TextButton
	end
	
	function Section:MultipleChoice(Text, Choices, CallBack)
		local CallBack = CallBack or function() end
		local TextButton = Instance.new("TextButton")

		TextButton.Text = Text .. " < ".. tostring(Choices[1]) .." >"
		TextButton.Parent = lib.MainGUIInstance
		TextButton.BorderSizePixel = 0
		TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextButton.Size = UDim2.new(1, 0, 0.05, 0)
		TextButton.ZIndex = 12
		TextButton.Font = Enum.Font.SourceSans
		TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextButton.TextSize = 14.000
		TextButton.Visible = false
		TextButton.AutoButtonColor = false
		TextButton.TextScaled = true
		if Section.CurrentObject then
			TextButton.Position = UDim2.new(1.1, 0, (Section.CurrentObject.Position.Y.Scale + Section.CurrentObject.Size.Y.Scale), 0)
		else
			TextButton.Position = UDim2.new(1.1, 0, 0.05, 0)
		end

		if #Section.IObjects <= 0 then
			Section.CurrentlySelectedObject = TextButton
			Section.CurrentlySelectedObject.Text = "> " .. Section.CurrentlySelectedObject.Text
			Section.ButtonNumber = 1
		end
		
		local ReceiveFunction = function()
			local Found
			for i,v in pairs(Section.IObjects) do
				if v[1] == TextButton then
					Found = true
					if v[3] > #Choices then
						v[3] = #Choices
					end
					if v[3] <= 0 then
						v[3] = 1
					end
					TextButton.Text = "> " .. Text .. " < " .. tostring(Choices[v[3]]) .. " >"
					CallBack(v[3])
					break
				end
			end
			if not Found then
				TextButton.Text = "> " .. Text .. " < " .. tostring(Choices[1]) .. " >"
			end
		end
		
		table.insert(Section.Objects, #Section.Objects+1, TextButton)
		table.insert(Section.IObjects, #Section.IObjects+1, {TextButton, ReceiveFunction, 1})
		Section.CurrentObject = TextButton
	end
	
	function Section:Text(Text)
		local TextLabel = Instance.new("TextLabel")

		TextLabel.Text = Text
		TextLabel.Parent = lib.MainGUIInstance
		TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Size = UDim2.new(1, 0, 0.05, 0)
		TextLabel.ZIndex = 12
		TextLabel.Font = Enum.Font.SourceSans
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 14.000
		TextLabel.Visible = false
		if Section.CurrentObject then
			TextLabel.Position = UDim2.new(1.1, 0, (Section.CurrentObject.Position.Y.Scale + Section.CurrentObject.Size.Y.Scale), 0)
		else
			TextLabel.Position = UDim2.new(1.1, 0, 0.05, 0)
		end

		table.insert(Section.Objects, #Section.Objects+1, TextLabel)
		Section.CurrentObject = TextLabel
	end
	
	UserInputService.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			if Section.KeybindBusy and Section.CurrentlySelectedObject then
				local SectionIOBject
				for i,v in pairs(Section.IObjects) do
					if v[1] == Section.CurrentlySelectedObject and v[2] and v[3] then
						SectionIOBject = v
					end
				end
				if SectionIOBject[2] then
					SectionIOBject[3] = "LMB"
					SectionIOBject[2](true)
				end
			else
				for i,v in pairs(lib.KeyBinds) do
					if v[1] == "LMB" then
						v[2](true)
					end
				end
			end
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then
			if Section.KeybindBusy and Section.CurrentlySelectedObject then
				local SectionIOBject
				for i,v in pairs(Section.IObjects) do
					if v[1] == Section.CurrentlySelectedObject and v[2] and v[3] then
						SectionIOBject = v
					end
				end
				if SectionIOBject[2] then
					SectionIOBject[3] = "RMB"
					SectionIOBject[2](true)
				end
			else
				for i,v in pairs(lib.KeyBinds) do
					if v[1] == "RMB" then
						v[2](true)
					end
				end
			end
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton3 then
			if Section.KeybindBusy and Section.CurrentlySelectedObject then
				local SectionIOBject
				for i,v in pairs(Section.IObjects) do
					if v[1] == Section.CurrentlySelectedObject and v[2] and v[3] then
						SectionIOBject = v
					end
				end
				if SectionIOBject[2] then
					SectionIOBject[3] = "MMB"
					SectionIOBject[2](true)
				end
			else
				for i,v in pairs(lib.KeyBinds) do
					if v[1] == "MMB" then
						v[2](true)
					end
				end
			end
		end
		if Input.UserInputType == Enum.UserInputType.Keyboard and lib.CurrentlySelectedSection == SectionButton and SectionButton.Visible == true and Section.CurrentlySelectedObject and lib.Focused == true and lib.MainGUIInstance.Visible == true then
			if #Section.IObjects > 0 then
				local SectionIOBject
				for i,v in pairs(Section.IObjects) do
					if v[1] == Section.CurrentlySelectedObject and v[2] and v[3] then
						SectionIOBject = v
					end
				end
				if SectionIOBject then
					if Input.KeyCode == Enum.KeyCode.Left then
						if tonumber(SectionIOBject[3]) then
							SectionIOBject[3] -= 1
							SectionIOBject[2]()
						end
					end
					if Input.KeyCode == Enum.KeyCode.Right then
						if tonumber(SectionIOBject[3]) then
							SectionIOBject[3] += 1
							SectionIOBject[2]()
						end
					end
				end
				if Section.KeybindBusy and SectionIOBject[2] then
					SectionIOBject[3] = Input.KeyCode
					SectionIOBject[2](true)
				else
					if Section.Focused then else
						if Input.KeyCode == Enum.KeyCode.Down or Input.KeyCode == Enum.KeyCode.LeftBracket then
							if Section.ButtonNumber+1 <= #Section.IObjects then
								if Section.CurrentlySelectedObject then
									if Section.CurrentlySelectedObject:IsA("TextButton") then
										local Text = Section.CurrentlySelectedObject.Text
										Section.CurrentlySelectedObject.Text = Text:gsub("> ", "")
									end
								end
								Section.ButtonNumber += 1
								Section.CurrentlySelectedObject = Section.IObjects[Section.ButtonNumber][1]
								if Section.CurrentlySelectedObject then
									if Section.CurrentlySelectedObject:IsA("TextButton") then
										Section.CurrentlySelectedObject.Text = "> " .. Section.CurrentlySelectedObject.Text
									end
								end
							end
						end
						if Input.KeyCode == Enum.KeyCode.Up or Input.KeyCode == Enum.KeyCode.RightBracket then
							if Section.ButtonNumber-1 > 0 then
								if Section.CurrentlySelectedObject then
									if Section.CurrentlySelectedObject:IsA("TextButton") then
										local Text = Section.CurrentlySelectedObject.Text
										Section.CurrentlySelectedObject.Text = Text:gsub("> ", "")
									end
								end
								Section.ButtonNumber -= 1
								Section.CurrentlySelectedObject = Section.IObjects[Section.ButtonNumber][1]
								if Section.CurrentlySelectedObject then
									if Section.CurrentlySelectedObject:IsA("TextButton") then
										Section.CurrentlySelectedObject.Text = "> " .. Section.CurrentlySelectedObject.Text
									end
								end
							end
						end
					end
					if Input.KeyCode == Enum.KeyCode.Return then
						if Section.CurrentlySelectedObject then
							if SectionIOBject and SectionIOBject[4] and tostring(SectionIOBject[4]) == "Keybind" then
								if Section.KeybindBusy then else
									Section.KeybindBusy = true
								end
							else
								if Section.Focused then
									for i,v in pairs(Section.IObjects) do
										if v == Section.CurrentlySelectedObject then
											v[2]()
										end
									end
									Section.Focused = false
								else
									local IsToggle = false
									for i,v in pairs(Section.Toggles) do
										if v[1] == Section.CurrentlySelectedObject then
											if v[2] then
												v[3] = not v[3]
												if v[3] == true then
													local Text = Section.CurrentlySelectedObject.Text
													Section.CurrentlySelectedObject.Text = Text:gsub("%[OFF%]", "")
													Section.CurrentlySelectedObject.Text = Section.CurrentlySelectedObject.Text .. "[ON]"
												else
													local Text = Section.CurrentlySelectedObject.Text
													Section.CurrentlySelectedObject.Text = Text:gsub("%[ON%]", "")
													Section.CurrentlySelectedObject.Text = Section.CurrentlySelectedObject.Text .. "[OFF]"
												end
												v[2](v[3])
												IsToggle = true
											end
										end
									end
									if not IsToggle then
										for i,v in pairs(Section.IObjects) do
											if v[1] and v[2] then
												if v[1] == Section.CurrentlySelectedObject then
													v[2]()
												end
											end
										end
									end
								end
							end
						end
					end
					if Input.KeyCode == Enum.KeyCode.Backspace and not Section.Focused then
						lib.Focused = false
						for i,v in pairs(Section.Objects) do
							v.Visible = false
						end
					end
					if Section.Focused then
						for i,v in pairs(Section.IObjects) do
							if v[1] == Section.CurrentlySelectedObject then
								if v[2] and v[3] then
									if tonumber(v[3]) then else
										local WhitelistedChars = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890"
										if Input.KeyCode == Enum.KeyCode.Backspace then
											local TextLength = tostring(v[3]):len()
											local OriginalText = tostring(v[3])
											v[3] = ""
											for i = 1,TextLength,1 do
												if i == TextLength then else
													v[3] = tostring(v[3] .. OriginalText:sub(i,i))
												end
											end
											v[2]()
										else
											for i = 1,WhitelistedChars:len(),1 do
												if WhitelistedChars:sub(i,i) == Input.KeyCode.Name then
													v[3] = tostring(tostring(v[3]) .. Input.KeyCode.Name:lower())
													v[2]()
													break
												end
											end
										end
									end
								end
							end
						end
					--[[else
						for i,v in pairs(lib.KeyBinds) do
							if v[1] and v[2] then
								if v[1] == Input.KeyCode then
									v[2](true)
								end
							end
						end]]
					end
				end
			end
		end
	end)
	--[[UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			if Section.KeybindBusy and Section.CurrentlySelectedObject then else
				for i,v in pairs(lib.KeyBinds) do
					if v[1] == "LMB" then
						v[2](false)
					end
				end
			end
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton2 then
			if Section.KeybindBusy and Section.CurrentlySelectedObject then else
				for i,v in pairs(lib.KeyBinds) do
					if v[1] == "RMB" then
						v[2](false)
					end
				end
			end
		end
		if Input.UserInputType == Enum.UserInputType.MouseButton3 then
			if Section.KeybindBusy and Section.CurrentlySelectedObject then else
				for i,v in pairs(lib.KeyBinds) do
					if v[1] == "MMB" then
						v[2](false)
					end
				end
			end
		end
		if Input.UserInputType == Enum.UserInputType.Keyboard and lib.CurrentlySelectedSection == SectionButton and SectionButton.Visible == true and Section.CurrentlySelectedObject and lib.Focused == true and lib.MainGUIInstance.Visible == true then
			if #Section.IObjects > 0 then
				local SectionIOBject
				for i,v in pairs(Section.IObjects) do
					if v[1] == Section.CurrentlySelectedObject and v[2] and v[3] then
						SectionIOBject = v
					end
				end
				if SectionIOBject then
					if not Section.Focused then
						for i,v in pairs(lib.KeyBinds) do
							if v[1] and v[2] then
								if v[1] == Input.KeyCode then
									v[2](false)
								end
							end
						end
					end
				end
			end
		end
	end)]]
	
	return Section
end

UserInputService.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == "LMB" then
					v[2](false)
				end
			end
		end
	end
	if Input.UserInputType == Enum.UserInputType.MouseButton2 then
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == "RMB" then
					v[2](false)
				end
			end
		end
	end
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == "MMB" then
					v[2](false)
				end
			end
		end
	end
	if Input.UserInputType == Enum.UserInputType.Keyboard then
		if Input.KeyCode == lib.BindKeycode then
			lib.MainGUIInstance.Visible = not lib.MainGUIInstance.Visible
		end
		if not lib.Focused and lib.MainGUIInstance.Visible == true and lib.MainGUIInstance.Visible == true then
			if Input.KeyCode == Enum.KeyCode.LeftBracket or Input.KeyCode == Enum.KeyCode.Down then
				if #lib.Sections > 0 then
					if lib.CurrentSectionNumber+1 <= #lib.Sections then
						if lib.Sections[lib.CurrentSectionNumber+1] then
							lib.CurrentlySelectedSection.Text = lib.CurrentlySelectedSection.Text:gsub("> ", "")
							lib.CurrentSectionNumber += 1
							lib.CurrentlySelectedSection = lib.Sections[lib.CurrentSectionNumber][1]
							lib.CurrentlySelectedSection.Text = "> " .. lib.CurrentlySelectedSection.Text
						end
					end
				end
			end
			if Input.KeyCode == Enum.KeyCode.RightBracket or Input.KeyCode == Enum.KeyCode.Up then
				if #lib.Sections > 0 then
					if lib.CurrentSectionNumber-1 > 0 then
						if lib.Sections[lib.CurrentSectionNumber-1] then
							lib.CurrentlySelectedSection.Text = lib.CurrentlySelectedSection.Text:gsub("> ", "")
							lib.CurrentSectionNumber -= 1
							lib.CurrentlySelectedSection = lib.Sections[lib.CurrentSectionNumber][1]
							lib.CurrentlySelectedSection.Text = "> " .. lib.CurrentlySelectedSection.Text
						end
					end
				end
			end
			if Input.KeyCode == Enum.KeyCode.Return then
				lib.Focused = true
				for i,v in pairs(lib.Sections[lib.CurrentSectionNumber][2].Objects) do
					v.Visible = true
				end
			end
		end
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == Input.KeyCode then
					v[2](false)
				end
			end
		end
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == "LMB" then
					v[2](true)
				end
			end
		end
	end
	if Input.UserInputType == Enum.UserInputType.MouseButton2 then
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == "RMB" then
					v[2](true)
				end
			end
		end
	end
	if Input.UserInputType == Enum.UserInputType.MouseButton1 then
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == "MMB" then
					v[2](true)
				end
			end
		end
	end
	if Input.UserInputType == Enum.UserInputType.Keyboard then
		local Pass = true
		for i,v in pairs(lib.Sections) do
			if v.KeybindBusy then
				Pass = false
			end
		end
		if Pass then
			for i,v in pairs(lib.KeyBinds) do
				if v[1] == Input.KeyCode then
					v[2](true)
				end
			end
		end
	end
end)

return lib
