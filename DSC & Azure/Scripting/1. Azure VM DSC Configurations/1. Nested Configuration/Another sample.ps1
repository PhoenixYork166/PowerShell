Configuration NestedFileConfig
{
    Node localhost
    {
    #To nest a configuration named FileConfig name NestedFileConfig
     FileConfig NestedConfig
     {
      CopyFrom='C:\Test1\mytestfile.txt'
    CopyTo='C:\Test2'
     }
}}