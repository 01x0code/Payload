-- LocalScript / Client Luau: ลบออบเจกต์ที่ Client เข้าถึงและลบได้ทั้งหมด

local function safeDestroy(obj: Instance)
	pcall(function()
		obj:Destroy()
	end)
end

local function clearContainer(container: Instance)
	for _, child in ipairs(container:GetChildren()) do
		safeDestroy(child)
	end
end

-- ลบออบเจกต์หลักที่อยู่ภายใต้ Client
local targets = {
	workspace,
	game:GetService("ReplicatedStorage"),
	game:GetService("StarterGui"),
	game:GetService("StarterPack"),
	game:GetService("StarterPlayer"),
	game:GetService("SoundService"),
	game:GetService("Lighting"),
	game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui"),
	game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:FindFirstChildOfClass("Backpack"),
}

for _, target in ipairs(targets) do
	if target then
		clearContainer(target)
	end
end

-- ลองไล่ลบทุกอย่างที่เข้าถึงได้จาก root ของ game (ครอบคลุมส่วนที่เหลือที่ลบได้)
for _, descendant in ipairs(game:GetDescendants()) do
	safeDestroy(descendant)
end
