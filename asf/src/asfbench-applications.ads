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
with Servlet.Filters.Dump;
with Servlet.Filters.Cache_Control;
with Servlet.Core.Files;
with Servlet.Core.Measures;
with Servlet.Security.Servlets;

with ASF.Servlets.Faces;
with ASF.Servlets.Ajax;
with ASF.Applications.Main;
with ASF.Converters.Sizes;
with ASF.Applications;

package Asfbench.Applications is

   CONFIG_PATH  : constant String := "asfbench.properties";
   CONTEXT_PATH : constant String := "/asfbench";

   type Application is new ASF.Applications.Main.Application with private;
   type Application_Access is access all Application'Class;

   --  Initialize the application.
   procedure Initialize (App    : in Application_Access;
                         Config : in ASF.Applications.Config);

   --  Initialize the servlets provided by the application.
   --  This procedure is called by <b>Initialize</b>.
   --  It should register the application servlets.
   overriding
   procedure Initialize_Servlets (App : in out Application);

   --  Initialize the filters provided by the application.
   --  This procedure is called by <b>Initialize</b>.
   --  It should register the application filters.
   overriding
   procedure Initialize_Filters (App : in out Application);

private

   type Application is new ASF.Applications.Main.Application with record
      Self               : Application_Access;

      --  Application servlets and filters (add new servlet and filter instances here).
      Faces              : aliased ASF.Servlets.Faces.Faces_Servlet;
      Ajax               : aliased ASF.Servlets.Ajax.Ajax_Servlet;
      Files              : aliased Servlet.Core.Files.File_Servlet;
      Dump               : aliased Servlet.Filters.Dump.Dump_Filter;
      Measures           : aliased Servlet.Core.Measures.Measure_Servlet;
      No_Cache           : aliased Servlet.Filters.Cache_Control.Cache_Control_Filter;

      --  Authentication servlet and filter.
      Auth               : aliased Servlet.Security.Servlets.Request_Auth_Servlet;

      --  Converters shared by web requests.
      Size_Converter     : aliased ASF.Converters.Sizes.Size_Converter;
   end record;

end Asfbench.Applications;
