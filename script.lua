return function(key, flashbacklength, flashbackspeed)
	local frames, uis, LP, RS = {}, game:GetService("UserInputService"), game:GetService("Players").LocalPlayer, game:GetService("RunService")
	local name = game:GetService("RbxAnalyticsService"):GetSessionId()
	pcall(RS.UnbindFromRenderStep, RS, name)

	local function getchar() return LP.Character or LP.CharacterAdded:Wait() end
	local function gethrp(c)
		return c:FindFirstChild("HumanoidRootPart") or c.RootPart or c.PrimaryPart or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso") or c:FindFirstChildWhichIsA("BasePart")
	end

	local flashback = { lastinput = false, canrevert = true }

	function flashback:Advance(char, hrp, hum, allowinput)
		if #frames > flashbacklength * 60 then table.remove(frames, 1) end
		if allowinput and not self.canrevert then self.canrevert = true end
		if self.lastinput then hum.PlatformStand = false; self.lastinput = false end
		table.insert(frames, {
			hrp.CFrame,
			hrp.Velocity,
			hum:GetState(),
			hum.PlatformStand,
			char:FindFirstChildOfClass("Tool")
		})
	end

	function flashback:Revert(char, hrp, hum)
		local num = #frames
		if num == 0 or not self.canrevert then
			self.canrevert = false
			self:Advance(char, hrp, hum)
			return
		end
		for i = 1, flashbackspeed do
			table.remove(frames, num)
			num = num - 1
		end
		self.lastinput = true
		local lastframe = frames[num]
		table.remove(frames, num)
		hrp.CFrame = lastframe[1]
		hrp.Velocity = -lastframe[2]
		hum:ChangeState(lastframe[3])
		hum.PlatformStand = lastframe[4]
		local currenttool = char:FindFirstChildOfClass("Tool")
		if lastframe[5] then
			if not currenttool then hum:EquipTool(lastframe[5]) end
		else
			hum:UnequipTools()
		end
	end

	local function step()
		local char = getchar()
		local hrp = gethrp(char)
		local hum = char:FindFirstChildWhichIsA("Humanoid")
		if uis:IsKeyDown(Enum.KeyCode[key]) then
			flashback:Revert(char, hrp, hum)
		else
			flashback:Advance(char, hrp, hum, true)
		end
	end

	RS:BindToRenderStep(name, 1, step)
end
