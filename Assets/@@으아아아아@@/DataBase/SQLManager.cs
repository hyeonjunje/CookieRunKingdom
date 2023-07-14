using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.IO;
using LitJson;
using MySql.Data.MySqlClient;
using System.Reflection;

public class UserInfo
{
    public string Id { get; private set; }
    public string Pw { get; private set; }
    public string KingdomName { get; private set; }
    public int IsFirst { get; private set; }
    public int Money { get; private set; }
    public int Dia { get; private set; }
    public int Jelly { get; private set; }
    public int MaxJelly { get; private set; }

    public List<CookieInfo> AllCookies { get; private set; }
    public List<CraftableBuildingInfo> OwnedCraftableBuildings { get; private set; }

    public UserInfo(string id, string pw, string name = "", int isFirst = 0, int money = 0, int dia = 0, int jelly = 0, int maxJelly = 0, string allCookies = "", string ownedCraftableBuildings = "")
    {
        Id = id;
        Pw = pw;

        SetData(name, isFirst, money, dia, jelly, maxJelly, allCookies, ownedCraftableBuildings);
    }

    public void SetData(string name, int isFirst, int money, int dia, int jelly, int maxJelly, string allCookies, string ownedCraftableBuildings)
    {
        // 저장하자
        KingdomName = name;
        IsFirst = isFirst;
        Money = money;
        Dia = dia;

        // 처음이 아니면 그대로 읽는다.
        if(isFirst != 0)
        {
            Debug.Log("처음이 아니구ㅡㄴ");

            Jelly = jelly;
            MaxJelly = maxJelly;

            // 복잡한건 json으로 저장하자
            AllCookies = JsonUtility.FromJson<List<CookieInfo>>(allCookies);
            OwnedCraftableBuildings = JsonUtility.FromJson<List<CraftableBuildingInfo>>(ownedCraftableBuildings);
        }
        // 처음이라면 설정해준다.
        else
        {
            Debug.Log("처음하는군");

            Jelly = 45;
            MaxJelly = 45;

            AllCookies = new List<CookieInfo>();
            OwnedCraftableBuildings = new List<CraftableBuildingInfo>();

            for (int i = 0; i < 10; i++)
            {
                AllCookies.Add(new CookieInfo(i, false, false));
            }

            AllCookies[0] = new CookieInfo(0, true, true, 0);
            AllCookies[1] = new CookieInfo(1, true, true, 1);
            AllCookies[2] = new CookieInfo(2, true, true, 3);
            AllCookies[6] = new CookieInfo(6, true, true, 4);
            AllCookies[8] = new CookieInfo(8, true, true, 8);

            for(int i = 0; i < 21; i++)
            {
                OwnedCraftableBuildings.Add(new CraftableBuildingInfo(i, 4, true));
            }
        }
    }

    public void SetData(string name, int isFirst, int money, int dia, int jelly, int maxJelly, List<CookieInfo> allCookies, List<CraftableBuildingInfo> ownedCraftableBuildings)
    {
        // 저장하자
        KingdomName = name;
        IsFirst = isFirst;
        Money = money;
        Dia = dia;
        Jelly = jelly;
        MaxJelly = maxJelly;

        // 복잡한건 json으로 저장하자
        AllCookies = allCookies;
        OwnedCraftableBuildings = ownedCraftableBuildings;
    }
}

public class SQLManager
{
    private MySqlConnection _connection;
    private MySqlDataReader _reader;
    private string _dbPath = string.Empty;

    public UserInfo UserInfo { get; private set; }

    public SQLManager()
    {

    }

    public void Init()
    {
        _dbPath = Application.dataPath + "/DataBase";
        string serverInfo = SetServer(_dbPath);
        try
        {
            if (serverInfo == string.Empty)
            {
                Debug.Log("SQL_Server NULL! not connected");
                return;
            }
            _connection = new MySqlConnection(serverInfo);
            _connection.Open();
            Debug.Log("SQL OPEN Complete");
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
        }
    }

    private string SetServer(string path)
    {
        try
        {
            if (!File.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string jsonString = File.ReadAllText(path + "/config.json");
            JsonData itemData = JsonMapper.ToObject(jsonString);
            string serverInfo = $"Server={itemData[0]["IP"]};Database={itemData[0]["TableName"]};Uid={itemData[0]["ID"]};Pwd={itemData[0]["PW"]}; Port={itemData[0]["PORT"]};CharSet=utf8;";

            return serverInfo;
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            return string.Empty;
        }
    }

    private bool ConnectCheck(MySqlConnection c)
    {
        if (c.State != System.Data.ConnectionState.Open)
        {
            c.Open();
            if (c.State != System.Data.ConnectionState.Open)
            {
                return false;
            }
        }
        return true;
    }

    public bool Login(string inputId, string inputPw)
    {
        if (!ConnectCheck(_connection))
        {
            return false;
        }
        string SQLCommand =
            string.Format(@"SELECT Id,Pw,KingdomName,IsFirst,Money,Dia,Jelly,MaxJelly,Cookies,Buildings  FROM user_login_info
                            WHERE Id = '{0}' AND Pw = '{1}';", inputId, inputPw);
        MySqlCommand cmd = new MySqlCommand(SQLCommand, _connection);
        _reader = cmd.ExecuteReader();

        if (_reader.HasRows)
        {
            while (_reader.Read())
            {
                string id = (_reader.IsDBNull(0)) ? string.Empty : (string)_reader["Id"].ToString();
                string pw = (_reader.IsDBNull(1)) ? string.Empty : (string)_reader["Pw"].ToString();
                string kingdomName = (_reader.IsDBNull(2)) ? string.Empty : (string)_reader["KingdomName"].ToString();
                int isFirst = (_reader.IsDBNull(3)) ? 0 : int.Parse(_reader["IsFirst"].ToString());
                int money = (_reader.IsDBNull(4)) ? 0 : int.Parse(_reader["Money"].ToString());
                int dia = (_reader.IsDBNull(5)) ? 0 : int.Parse(_reader["Dia"].ToString());
                int jelly = (_reader.IsDBNull(6)) ? 0 : int.Parse(_reader["Jelly"].ToString());
                int maxJelly = (_reader.IsDBNull(7)) ? 0 : int.Parse(_reader["MaxJelly"].ToString());

                // json
                string cookies = (_reader.IsDBNull(8)) ? string.Empty : (string)_reader["Cookies"].ToString();
                string buildings = (_reader.IsDBNull(9)) ? string.Empty : (string)_reader["Buildings"].ToString();

                UserInfo = new UserInfo(id, pw, kingdomName, isFirst, money, dia, jelly, maxJelly, cookies, buildings);

                if (!_reader.IsClosed)
                _reader.Close();

                return true;
            }

            if (!_reader.IsClosed)
                _reader.Close();
            return false;
        }
        else
        {
            if (!_reader.IsClosed)
                _reader.Close();
            return false;
        }
    }

    public void SignUp(string id, string pw)
    {
        string SQLCommand = string.Format(@"INSERT INTO user_login_info (Id, Pw) VALUES ('{0}', '{1}');", id, pw);
        using (MySqlCommand command = new MySqlCommand(SQLCommand, _connection))
        {
            command.ExecuteNonQuery();
        }
        UserInfo = new UserInfo(id, pw);
    }


    // 데이터베이스에 저장한다.
    public void SaveDataBase()
    {
        // userInfo의 데이터를 id와 pw를 읽어서 그에 맞는 데이터에 다 저장한다.
        PropertyInfo[] properties = UserInfo.GetType().GetProperties();
        string SQLCommand = string.Empty;

        // 첫번째와 두번째는 id와 pw
        for (int i = 2; i < properties.Length - 2; i++)
        {
            SQLCommand = string.Format(@"UPDATE user_login_info SET {0}= '{1}' WHERE  Id= '{2}' AND Pw= '{3}';",
                properties[i].Name, properties[i].GetValue(UserInfo), properties[0].GetValue(UserInfo), properties[1].GetValue(UserInfo));
            using(MySqlCommand command = new MySqlCommand(SQLCommand, _connection))
            {
                command.ExecuteNonQuery();
            }
        }

        // 쿠키 정보
        string allCookies = JsonUtility.ToJson(UserInfo.AllCookies);
        SQLCommand = string.Format(@"UPDATE user_login_info SET {0}= '{1}' WHERE  Id= '{2}' AND Pw= '{3}';",
                "Cookies", allCookies, properties[0].GetValue(UserInfo), properties[1].GetValue(UserInfo));
        using (MySqlCommand command = new MySqlCommand(SQLCommand, _connection))
        {
            command.ExecuteNonQuery();
        }

        // 건물 정보
        string allBuildings = JsonUtility.ToJson(UserInfo.OwnedCraftableBuildings);
        SQLCommand = string.Format(@"UPDATE user_login_info SET {0}= '{1}' WHERE  Id= '{2}' AND Pw= '{3}';",
                "Buildings", allBuildings, properties[0].GetValue(UserInfo), properties[1].GetValue(UserInfo));
        using (MySqlCommand command = new MySqlCommand(SQLCommand, _connection))
        {
            command.ExecuteNonQuery();
        }
    }
}
