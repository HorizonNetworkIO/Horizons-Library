
// Full Spawn Hook \\
local meta = FindMetaTable("Player")

if SERVER then
    hook.Add("PlayerInitialSpawn", "HZNLib:PISFull", function(ply)
        local PlayerHookID = string.format("HZNLib:PISFull:%s", ply:SteamID())
        hook.Add("SetupMove", PlayerHookID, function(pl2, _, mvc)
            if (!IsValid(pl2)) then return end
            if (ply != pl2) then return end
            if mvc:IsForced() then return end

            hook.Run("HZNLib:FullSpawn", ply)
            hook.Remove("SetupMove", PlayerHookID)
            ply:SetNWBool("HZNLib:FullSpawn", true)
        end)
    end)
end

function meta:HZN_FullySpawned()
    if not IsValid(self) then return false end
    return self:GetNWBool("HZNLib:FullSpawn", false)
end