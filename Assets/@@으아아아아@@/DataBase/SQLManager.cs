using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.IO;
using LitJson;
using MySql.Data.MySqlClient;

public class UserInfo
{
    public string Id { get; private set; }
    public string Pw { get; private set; }
    public string Name { get; private set; }
    public int IsFirst { get; private set; }
    public int Money { get; private set; }
    public int Dia { get; private set; }
    public int Jelly { get; private set; }
    public int MaxJelly { get; private set; }

    public UserInfo(string id, string pw, string name = "", int isFirst = 0, int money = 0, int dia = 0, int jelly = 0, int maxJelly = 0)
    {
        Id = id;
        Pw = pw;

        SetData(name, isFirst, money, dia, jelly, maxJelly);
    }

    public void SetData(string name, int isFirst, int money, int dia, int jelly, int maxJelly)
    {
        Name = name;
        IsFirst = isFirst;
        Money = money;
        Dia = dia;
        Jelly = jelly;
        MaxJelly = maxJelly;

        // 저장하자
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
            string.Format(@"SELECT Id,Pw,KingdomName,IsFirst,Money,Dia,Jelly,MaxJelly  FROM user_login_info
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

                UserInfo = new UserInfo(id, pw, kingdomName, isFirst, money, dia, jelly, maxJelly);

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
        Debug.Log("생성~");
        UserInfo = new UserInfo(id, pw);
    }


    // 데이터베이스에 저장한다.
    public void SaveDataBase()
    {
        // id와 pw로 데이터를 조회해
        // userInfo로 데이터를 덧씌운다.
    }
}
