using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.IO;
using LitJson;
using MySql.Data.MySqlClient;

public class UserInfo2
{
    public string U_Name { get; private set; }
    public string U_Password { get; private set; }
    public string U_Birthday { get; private set; }

    public UserInfo2(string name, string password, string birthday)
    {
        U_Name = name;
        U_Password = password;
        U_Birthday = birthday;
    }
}


public class SQLControll : MonoBehaviour
{
    public MySqlConnection con;
    public MySqlDataReader reader;

    private string DB_Path = string.Empty;

    public UserInfo2 info;

    public static SQLControll instance = null;

    private void Awake()
    {
        if(instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
            return;
        }

        DB_Path = Application.dataPath + "/DataBase";
        string serverInfo = SetServer(DB_Path);
        Debug.Log(serverInfo);
        try
        {
            if(serverInfo == string.Empty)
            {
                Debug.Log("SQL_Server NULL! not connected");
                return;
            }
            con = new MySqlConnection(serverInfo);
            con.Open();
            Debug.Log("SQL OPEN Complete");
        }
        catch(Exception e)
        {
            Debug.Log(e.Message);
        }
    }

    private string SetServer(string path)
    {
        try
        {
            if(!File.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string jsonString = File.ReadAllText(path + "/config.json");
            JsonData itemData = JsonMapper.ToObject(jsonString);
            string serverInfo = $"Server={itemData[0]["IP"]};Database={itemData[0]["TableName"]};Uid={itemData[0]["ID"]};Pwd={itemData[0]["PW"]}; Port={itemData[0]["PORT"]};CharSet=utf8;";

            return serverInfo;
        }
        catch(Exception e)
        {
            Debug.Log(e.Message);
            return string.Empty;
        }
    }

    private bool ConnectCheck(MySqlConnection c)
    {
        if(c.State != System.Data.ConnectionState.Open)
        {
            c.Open();
            if(c.State != System.Data.ConnectionState.Open)
            {
                return false;
            }
        }
        return true;
    }

    public bool Login(string id, string pw)
    {
        try
        {
            if(!ConnectCheck(con))
            {
                return false;
            }
            string SQLCommand =
            string.Format(@"SELECT U_name, U_Password, U_Birthday FROM user_login_info
                            WHERE U_name = '{0}' AND U_Password = '{1}';", id, pw);
            MySqlCommand cmd = new MySqlCommand(SQLCommand, con);
            reader = cmd.ExecuteReader();
            if(reader.HasRows)
            {
                while(reader.Read())
                {
                    string name = (reader.IsDBNull(0)) ? string.Empty : (string)reader["U_name"].ToString();
                    string password = (reader.IsDBNull(1)) ? string.Empty : (string)reader["U_Password"].ToString();
                    string birth = (reader.IsDBNull(2)) ? string.Empty : (string)reader["U_Birthday"].ToString();

                    if(!name.Equals(string.Empty) || !password.Equals(string.Empty))
                    {
                        info = new UserInfo2(name, password, birth);

                        if (!reader.IsClosed)
                            reader.Close();
                        return true;
                    }
                    else
                    {
                        break;
                    }
                }

                if (!reader.IsClosed)
                    reader.Close();
                return false;
            }
            else
            {
                if (!reader.IsClosed)
                    reader.Close();
                return false;
            }
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
            if (reader != null && !reader.IsClosed)
                reader.Close();
            return false;
        }
    }

    public void SignUp(string id, string pw)
    {
        if(Login(id, pw))
        {
            Debug.Log("이미 있는 계정입니다.");
            return;
        }

        if (!ConnectCheck(con))
        {
            return;
        }

        string query = string.Format("INSERT INTO user_login_info (U_name, U_Password, U_Birthday) VALUES ('{0}', '{1}', '{2}');", id, pw, "1102");
        using (MySqlCommand command = new MySqlCommand(query, con))
        {
            command.ExecuteNonQuery();
        }
    }
}
