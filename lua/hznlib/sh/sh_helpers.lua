HZNLib.USE_DISTANCE = 7000
HZNLib.VIEW_DISTANCE = 500000
function HZNLib:InDistance(ent1, ent2, distance)
    if (isnumber(ent2)) then
        if (ent1:GetPos():DistToSqr(LocalPlayer():GetPos()) <= ent2) then
            return true
        end
    else
        if (ent1:GetPos():DistToSqr(ent2:GetPos()) <= distance) then
            return true
        end
    end
    return false
end