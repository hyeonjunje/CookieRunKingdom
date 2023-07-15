using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.IO;
using LitJson;
using MySql.Data.MySqlClient;
using System.Reflection;

public class CookiesJson
{
    public List<CookieInfo> allCookies;

    public CookiesJson()
    {
        // 처음하면 용감한 쿠키, 딸기맛 쿠키, 마법사맛 쿠키, 칠리맛 쿠키, 커스타드3세맛 쿠키가 주어진다.
        allCookies = new List<CookieInfo>();

        for (int i = 0; i < 10; i++)
        {
            allCookies.Add(new CookieInfo(i, false, false));
        }

        allCookies[0] = new CookieInfo(0, true, true, 0);
        allCookies[1] = new CookieInfo(1, true, true, 1);
        allCookies[2] = new CookieInfo(2, true, true, 3);
        allCookies[6] = new CookieInfo(6, true, true, 4);
        allCookies[8] = new CookieInfo(8, true, true, 8);
    }
}

public class BuildingJson
{
    public List<BuildingInfo> allBuildings;

    public BuildingJson()
    {
        allBuildings = new List<BuildingInfo>();

        for (int i = 0; i < 21; i++)
        {
            allBuildings.Add(new BuildingInfo(i, 4, true));
        }
    }
}


public class UserInfo
{
    public string Id { get; private set; }
    public string Pw { get; private set; }
    public int KingdomIndex { get; private set; }
    public string KingdomName { get; private set; }
    public int IsFirst { get; private set; }
    public int Money { get; private set; }
    public int Dia { get; private set; }
    public int Jelly { get; private set; }
    public int MaxJelly { get; private set; }
    public string Cookies { get; private set; }
    public string Buildings { get; private set; }
    public string LastTime { get; private set; }
    public string ItemCount { get; private set; }

    private CookiesJson _cookieJson;
    private BuildingJson _buildingJson;

    public UserInfo(string id, string pw, int kingdomIndex = 0, string name = "", int isFirst = 0, int money = 0, 
        int dia = 0, int jelly = 0, int maxJelly = 0, string cookies = "", string buildings = "", string lastTime = "", string ItemCount = "")
    {
        Id = id;
        Pw = pw;

        LoadData(kingdomIndex, name, isFirst, money, dia, jelly, maxJelly, cookies, buildings, lastTime, ItemCount);
    }

    public void GetJsonData(ref List<CookieInfo> allCookies, ref List<BuildingInfo> allBuildings)
    {
        allCookies = _cookieJson.allCookies;
        allBuildings = _buildingJson.allBuildings;
    }

    // 게임 불러올 때
    public void LoadData(int kingdomIndex, string name, int isFirst, int money, int dia, int jelly, int maxJelly, string cookies, string buildings, string lastTime, string itemCount)
    {
        KingdomIndex = kingdomIndex;
        KingdomName = name;
        IsFirst = isFirst;
        Money = money;
        Dia = dia;
        ItemCount = itemCount;
        // 처음이 아니면 그대로 읽는다.
        if (isFirst != 0)
        {
            Debug.Log("처음이 아니구ㅡㄴ");

            Jelly = jelly;
            MaxJelly = maxJelly;
            Cookies = cookies;
            Buildings = buildings;
            LastTime = lastTime;

            _cookieJson = JsonUtility.FromJson<CookiesJson>(Cookies);
            _buildingJson = JsonUtility.FromJson<BuildingJson>(Buildings);
        }
        // 처음이라면 설정해준다.
        else
        {
            Debug.Log("처음하는군");

            Jelly = 45;
            MaxJelly = 45;
            LastTime = DateTime.Now.ToString("yyyyMMddHHmmss");

            _cookieJson = new CookiesJson();
            _buildingJson = new BuildingJson();
        }
    }

    // 게임 저장할 때
    public void SaveData(int kingdomIndex, string name, int isFirst, int money, int dia, int jelly, int maxJelly, List<CookieInfo> cookiesInfo, List<BuildingInfo> buildingsInfo, DateTime lastTime, string itemCount)
    {
        // 저장하자
        KingdomIndex = kingdomIndex;
        KingdomName = name;
        IsFirst = isFirst;
        Money = money;
        Dia = dia;
        Jelly = jelly;
        MaxJelly = maxJelly;

        // 복잡한건 json으로 저장하자
        _cookieJson.allCookies = cookiesInfo;
        _buildingJson.allBuildings = buildingsInfo;

        LastTime = lastTime.ToString("yyyyMMddHHmmss");

        Cookies = JsonUtility.ToJson(_cookieJson);
        Buildings = JsonUtility.ToJson(_buildingJson);

        ItemCount = itemCount;
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
            string.Format(@"SELECT Id,Pw,KingdomIndex,KingdomName,IsFirst,Money,Dia,Jelly,MaxJelly,Cookies,Buildings,LastTime,ItemCount  FROM user_login_info
                            WHERE Id = '{0}' AND Pw = '{1}';", inputId, inputPw);
        MySqlCommand cmd = new MySqlCommand(SQLCommand, _connection);
        _reader = cmd.ExecuteReader();

        if (_reader.HasRows)
        {
            while (_reader.Read())
            {
                string id = (_reader.IsDBNull(0)) ? string.Empty : (string)_reader["Id"].ToString();
                string pw = (_reader.IsDBNull(1)) ? string.Empty : (string)_reader["Pw"].ToString();
                int kingdomIndex = (_reader.IsDBNull(2)) ? 0 : int.Parse(_reader["KingdomIndex"].ToString());
                string kingdomName = (_reader.IsDBNull(3)) ? string.Empty : (string)_reader["KingdomName"].ToString();
                int isFirst = (_reader.IsDBNull(4)) ? 0 : int.Parse(_reader["IsFirst"].ToString());
                int money = (_reader.IsDBNull(5)) ? 0 : int.Parse(_reader["Money"].ToString());
                int dia = (_reader.IsDBNull(6)) ? 0 : int.Parse(_reader["Dia"].ToString());
                int jelly = (_reader.IsDBNull(7)) ? 0 : int.Parse(_reader["Jelly"].ToString());
                int maxJelly = (_reader.IsDBNull(8)) ? 0 : int.Parse(_reader["MaxJelly"].ToString());

                // json
                string cookies = (_reader.IsDBNull(9)) ? string.Empty : (string)_reader["Cookies"].ToString();
                string buildings = (_reader.IsDBNull(10)) ? string.Empty : (string)_reader["Buildings"].ToString();

                // DataTime
                string lastTime = (_reader.IsDBNull(11)) ? string.Empty : (string)_reader["LastTime"].ToString();
                string itemCount = (_reader.IsDBNull(12)) ? string.Empty : (string)_reader["ItemCount"].ToString();

                UserInfo = new UserInfo(id, pw, kingdomIndex, kingdomName, isFirst, money, dia, jelly, maxJelly, cookies, buildings, lastTime, itemCount);

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
        for (int i = 2; i < properties.Length ; i++)
        {
            SQLCommand = string.Format(@"UPDATE user_login_info SET {0}= '{1}' WHERE  Id= '{2}' AND Pw= '{3}';",
                properties[i].Name, properties[i].GetValue(UserInfo), properties[0].GetValue(UserInfo), properties[1].GetValue(UserInfo));
            using(MySqlCommand command = new MySqlCommand(SQLCommand, _connection))
            {
                command.ExecuteNonQuery();  
            }
        }
    }
}
