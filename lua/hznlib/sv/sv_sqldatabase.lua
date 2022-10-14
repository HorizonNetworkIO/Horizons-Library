function HZNLib:InitializeDatabase()
    HZNLib.db = mysqloo.connect(HZNLib.Config.MySQL.host, HZNLib.Config.MySQL.user, HZNLib.Config.MySQL.password, HZNLib.Config.MySQL.database, HZNLib.Config.MySQL.port)
    HZNLib.db:connect()

    HZNLib.db.onConnected = function()
        HZNLib:Log("Connected to MySQL database.")
        hook.Run("HZNLib:DatabaseConnected")
        HZNLib.DatabaseConnected = true
    end

    HZNLib.db.onConnectionFailed = function(db, err)
        HZNLib:Log("Connection to MySQL database failed! Error: " .. err)
    end
end

function HZNLib:Query(query, callback)
    if (!HZNLib.db) then 
        HZNLib:Log("Database not connected! Retrying connection...")
        
        HZNLib.db = mysqloo.connect(HZNLib.Config.MySQL.host, HZNLib.Config.MySQL.user, HZNLib.Config.MySQL.password, HZNLib.Config.MySQL.database, HZNLib.Config.MySQL.port)
        HZNLib.db:connect()

        HZNLib.db.onConnected = function()
            HZNLib:Log("Connected to MySQL database.")
            HZNLib:Query(query, callback)
        end
    end
    
    local q = HZNLib.db:query(query)
    q.onSuccess = function(q, data)
        callback(data)
    end
    q.onError = function(q, err)
        HZNLib:Log("MySQL Error: "..err)
    end
    q:start()
end