function HZNLib:DrawNPCOverhead(ent, text)
    local angle = EyeAngles()
    angle = Angle( 0, angle.y, 0 )

    angle:RotateAroundAxis( angle:Up(), -90 )
    angle:RotateAroundAxis( angle:Forward(), 90 )

    local center = ent:OBBCenter()
    local pos = LocalToWorld(center, angle, ent:GetPos(), ent:GetAngles())

    pos.z = pos.z + math.sin( CurTime() ) * 1.15

    if (HZNLib:InDistance(LocalPlayer(), ent, HZNLib.VIEW_DISTANCE)) then
        cam.Start3D2D(pos + Vector(0, 0, 45), angle, 0.1)
            draw.RoundedBox(10, -220, -40, 440, 85, HZNHud:GetColor(1))
            draw.SimpleText(text, "HZN:Bold@60", 0, 0, HZNHud:GetColor(3), 1, 1)
        cam.End3D2D()
    end
end