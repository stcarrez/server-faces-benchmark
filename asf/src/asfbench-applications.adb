-----------------------------------------------------------------------
--  asfbench -- asfbench applications
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

with Util.Log.Loggers;

package body Asfbench.Applications is

   Log     : constant Util.Log.Loggers.Logger := Util.Log.Loggers.Create ("Asfbench");

   --  ------------------------------
   --  Initialize the application:
   --  <ul>
   --     <li>Register the servlets and filters.
   --     <li>Register the application modules.
   --     <li>Define the servlet and filter mappings.
   --  </ul>
   --  ------------------------------
   procedure Initialize (App    : in Application_Access;
                         Config : in ASF.Applications.Config) is
      Fact  : ASF.Applications.Main.Application_Factory;
   begin
      App.Self := App;
      App.Initialize (Config, Fact);
      App.Set_Global ("contextPath", CONTEXT_PATH);
   end Initialize;

   --  ------------------------------
   --  Initialize the servlets provided by the application.
   --  This procedure is called by <b>Initialize</b>.
   --  It should register the application servlets.
   --  ------------------------------
   overriding
   procedure Initialize_Servlets (App : in out Application) is
   begin
      Log.Info ("Initializing application servlets...");

      ASF.Applications.Main.Application (App).Initialize_Servlets;
      App.Add_Servlet (Name => "faces", Server => App.Self.Faces'Access);
      App.Add_Servlet (Name => "files", Server => App.Self.Files'Access);
      App.Add_Servlet (Name => "ajax", Server => App.Self.Ajax'Access);
      App.Add_Servlet (Name => "measures", Server => App.Self.Measures'Access);
      App.Add_Servlet (Name => "auth", Server => App.Self.Auth'Access);
   end Initialize_Servlets;

   --  ------------------------------
   --  Initialize the filters provided by the application.
   --  This procedure is called by <b>Initialize</b>.
   --  It should register the application filters.
   --  ------------------------------
   overriding
   procedure Initialize_Filters (App : in out Application) is
   begin
      Log.Info ("Initializing application filters...");

      ASF.Applications.Main.Application (App).Initialize_Filters;
      App.Add_Filter (Name => "dump", Filter => App.Self.Dump'Access);
      App.Add_Filter (Name => "measures", Filter => App.Self.Measures'Access);
      App.Add_Filter (Name => "no-cache", Filter => App.Self.No_Cache'Access);
   end Initialize_Filters;

end Asfbench.Applications;
