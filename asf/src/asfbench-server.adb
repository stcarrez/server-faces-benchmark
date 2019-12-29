-----------------------------------------------------------------------
--  Asfbench-server -- Application server
--  Copyright (C) 2019 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------
with Ada.Exceptions;
with Ada.IO_Exceptions;

with Util.Log.Loggers;

with AWS.Config.Set;
with ASF.Server.Web;
with ASF.Applications.Main;
with ASF.Applications.Main.Configs;

with Asfbench.Applications;
procedure Asfbench.Server is

   Log          : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("Asfbench.Server");
   App          : constant Applications.Application_Access := new Applications.Application;
   C            : ASF.Applications.Config;

   procedure Configure (Config : in out AWS.Config.Object);

   WS      : ASF.Server.Web.AWS_Container;

   procedure Configure (Config : in out AWS.Config.Object) is
   begin
      AWS.Config.Set.Input_Line_Size_Limit (1_000_000);
      AWS.Config.Set.Max_Connection (Config, 8);
      AWS.Config.Set.Accept_Queue_Size (Config, 100);
      AWS.Config.Set.Send_Buffer_Size (Config, 128 * 1024);
      AWS.Config.Set.Upload_Size_Limit (Config, 100_000_000);
   end Configure;

begin
   C.Set (ASF.Applications.VIEW_EXT, ".html");
   C.Set (ASF.Applications.VIEW_DIR, "web");
   C.Set ("web.dir", "web");
   begin
      C.Load_Properties (Applications.CONFIG_PATH);
      Util.Log.Loggers.Initialize (Applications.CONFIG_PATH);

   exception
      when Ada.IO_Exceptions.Name_Error =>
         Log.Error ("Cannot read application configuration file {0}", Applications.CONFIG_PATH);

   end;
   C.Set ("contextPath", Asfbench.Applications.CONTEXT_PATH);

   WS.Configure (Configure'Access);
   WS.Start;
   Asfbench.Applications.Initialize (App, C);
   ASF.Applications.Main.Configs.Read_Configuration (App.all, "web/WEB-INF/web.xml");
   WS.Register_Application (Asfbench.Applications.CONTEXT_PATH, App.all'Access);
   Log.Info ("Connect you browser to: http://localhost:8080{0}/index.html",
             Asfbench.Applications.CONTEXT_PATH);

   delay 365.0 * 24.0 * 3600.0;
   App.Close;
exception
   when E : others =>
      Log.Error ("Exception in server: " &
                 Ada.Exceptions.Exception_Name (E) & ": " &
                 Ada.Exceptions.Exception_Message (E));
end Asfbench.Server;
