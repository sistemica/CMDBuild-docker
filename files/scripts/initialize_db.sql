-- Sample Structure:
SELECT * FROM cm_create_class('Deployment', 'Class', 'DESCR: Deployment|MODE: write|STATUS: active|SUPERCLASS: true|TYPE: class|USERSTOPPABLE: false');
SELECT * FROM cm_create_class('Environment', 'Class', 'DESCR: Environment|MODE: write|STATUS: active|SUPERCLASS: false|TYPE: class|USERSTOPPABLE: false');
SELECT * FROM cm_create_class('ConfigurationItems', 'Class', 'DESCR: ConfigurationItems|MODE: write|STATUS: active|SUPERCLASS: false|TYPE: class|USERSTOPPABLE: false');
SELECT * FROM cm_create_class('DeployableUnitConfig', 'Deployment', 'DESCR: DeployableUnitConfig|MODE: write|STATUS: active|SUPERCLASS: false|TYPE: class|USERSTOPPABLE: false');
SELECT * FROM cm_create_class('FunctionalComponent', 'Class', 'DESCR: Functional Component|MODE: write|STATUS: active|SUPERCLASS: false|TYPE: class|USERSTOPPABLE: false');
SELECT * FROM cm_create_class('DeployableUnit', 'Deployment', 'DESCR: DeployableUnit|MODE: write|STATUS: active|SUPERCLASS: false|TYPE: class|USERSTOPPABLE: false');
SELECT * FROM cm_create_class('LogicalHosts', 'Class', 'DESCR: Logical Hosts|MODE: write|STATUS: active|SUPERCLASS: false|TYPE: class|USERSTOPPABLE: false');
SELECT * FROM cm_create_class('ComponentType', 'Class', 'DESCR: ComponentType|MODE: write|STATUS: active|SUPERCLASS: false|TYPE: class|USERSTOPPABLE: false');

-- Lookups
INSERT INTO "LookUp" ("Notes", "Status", "Description", "Type", "Number", "IsDefault", "TranslationUuid", "Code", "User") VALUES (null,'A','AMX Application','ComponentType','2','false','0afad47c-5768-4fa5-8f23-51c4f840db11',null,'system');
INSERT INTO "LookUp" ("Notes", "Status", "Description", "Type", "Number", "IsDefault", "TranslationUuid", "Code", "User") VALUES (null,'A','CentraSite Virtual Service','ComponentType','3','false','f81e84d5-25b1-422d-873a-5348dc660e9c',null,'system');
INSERT INTO "LookUp" ("Notes", "Status", "Description", "Type", "Number", "IsDefault", "TranslationUuid", "Code", "User") VALUES (null,'A','Database Package','ComponentType','4','false','ad4600e1-9375-408f-8dff-82b742b1e0a5',null,'system');
INSERT INTO "LookUp" ("Notes", "Status", "Description", "Type", "Number", "IsDefault", "TranslationUuid", "Code", "User") VALUES (null,'A','WebMethods Application','ComponentType','5','false','f82ebc5b-1e19-4359-9df5-0aed7a03c4c6',null,'system');

-- Domains/Relations:
SELECT * FROM cm_create_domain('DeployableUnitToDeployableUnitConfig', 'LABEL: DeployableUnitToDeployableUnitConfig|DESCRDIR: contains|DESCRINV: has|MODE: write|STATUS: active|TYPE: domain|CLASS1: DeployableUnit|CLASS2: DeployableUnitConfig|CARDIN: 1:N|MASTERDETAIL: true|MDLABEL: contains|DISABLED1: |DISABLED2: ');
SELECT * FROM cm_create_domain('EnvironmentToConfigurationItem', 'LABEL: EnvironmentToConfigurationItem|DESCRDIR: has|DESCRINV: is set|MODE: write|STATUS: active|TYPE: domain|CLASS1: Environment|CLASS2: ConfigurationItems|CARDIN: 1:N|MASTERDETAIL: true|MDLABEL: has|DISABLED1: |DISABLED2: ');
SELECT * FROM cm_create_domain('ComponentTypeToDeployableUnitConfig', 'LABEL: ComponentTypeToDeployableUnitConfig|DESCRDIR: deployed in|DESCRINV: is type of|MODE: write|STATUS: active|TYPE: domain|CLASS1: ComponentType|CLASS2: DeployableUnitConfig|CARDIN: 1:N|MASTERDETAIL: true|MDLABEL: deployed in|DISABLED1: |DISABLED2: ');
SELECT * FROM cm_create_domain('DeployableUnitConfigToConfigItem', 'LABEL: DeployableUnitConfigToConfigItem|DESCRDIR: contains|DESCRINV: is part of|MODE: write|STATUS: active|TYPE: domain|CLASS1: DeployableUnitConfig|CLASS2: ConfigurationItems|CARDIN: 1:N|MASTERDETAIL: true|MDLABEL: contains|DISABLED1: |DISABLED2: ');
SELECT * FROM cm_create_domain('DeployableUnitConfigToEnvironment', 'LABEL: DeployableUnitConfigToEnvironment|DESCRDIR: is deployed on|DESCRINV: configured by|MODE: write|STATUS: active|TYPE: domain|CLASS1: DeployableUnitConfig|CLASS2: Environment|CARDIN: N:1|MASTERDETAIL: true|MDLABEL: on|DISABLED1: |DISABLED2: ');
SELECT * FROM cm_create_domain('FunctionalComponentToDeployableUnit', 'LABEL: FunctionalComponentToDeployableUnit|DESCRDIR: contains|DESCRINV: is part of|MODE: write|STATUS: active|TYPE: domain|CLASS1: FunctionalComponent|CLASS2: DeployableUnit|CARDIN: 1:N|MASTERDETAIL: true|MDLABEL: technical components|DISABLED1: |DISABLED2: ');

-- Attributes Create
SELECT * FROM cm_create_attribute('"Environment"'::regclass,'Scope','varchar(100)',null,false,false,'STATUS: active|BASEDSP: false|CLASSORDER: 0|DESCR: Scope|GROUP: |INDEX: 4|MODE: write|FIELDMODE: write');
SELECT * FROM cm_create_attribute('"ConfigurationItems"'::regclass,'Value','varchar(150)',null,false,false,'STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: Value|GROUP: |INDEX: 4|MODE: write|FIELDMODE: write');
SELECT * FROM cm_create_attribute('"ConfigurationItems"'::regclass,'Environment','int4',null,false,false,'REFERENCEDOM: EnvironmentToConfigurationItem|REFERENCEDIRECT: false|REFERENCETYPE: restrict|FILTER: |STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: Environment|GROUP: |INDEX: 6|MODE: write|FIELDMODE: write');
SELECT * FROM cm_create_attribute('"ConfigurationItems"'::regclass,'DeployableUnitConfig','int4',null,false,false,'REFERENCEDOM: DeployableUnitConfigToConfigItem|REFERENCEDIRECT: false|REFERENCETYPE: restrict|FILTER: |STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: DeployableUnitConfig|GROUP: |INDEX: 7|MODE: write|FIELDMODE: write');
SELECT * FROM cm_create_attribute('"DeployableUnit"'::regclass,'Version','varchar(20)',null,false,false,'STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: Version|GROUP: |INDEX: 5|MODE: write|FIELDMODE: write');
SELECT * FROM cm_create_attribute('"DeployableUnitConfig"'::regclass,'ComponentType','int4',null,false,false,'REFERENCEDOM: ComponentTypeToDeployableUnitConfig|REFERENCEDIRECT: false|REFERENCETYPE: restrict|FILTER: |STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: ComponentType|GROUP: |INDEX: 4|MODE: write|FIELDMODE: write');
SELECT * FROM cm_create_attribute('"DeployableUnitConfig"'::regclass,'DeployableUnit','int4',null,false,false,'REFERENCEDOM: DeployableUnitToDeployableUnitConfig|REFERENCEDIRECT: false|REFERENCETYPE: restrict|FILTER: |STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: DeployableUnit|GROUP: |INDEX: 5|MODE: write|FIELDMODE: write');
SELECT * FROM cm_create_attribute('"DeployableUnitConfig"'::regclass,'Environment','int4',null,false,false,'REFERENCEDOM: DeployableUnitConfigToEnvironment|REFERENCEDIRECT: false|REFERENCETYPE: restrict|FILTER: |STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: Environment|GROUP: |INDEX: 6|MODE: write|FIELDMODE: write')
SELECT * FROM cm_create_attribute('"DeployableUnit"'::regclass,'FunctionalComponent','int4',null,false,false,'REFERENCEDOM: FunctionalComponentToDeployableUnit|REFERENCEDIRECT: false|REFERENCETYPE: restrict|FILTER: |STATUS: active|BASEDSP: true|CLASSORDER: 0|DESCR: FunctionalComponent|GROUP: |INDEX: 5|MODE: write|FIELDMODE: write');

-- Attributes Modify
SELECT * FROM cm_modify_attribute('"DeployableUnitConfig"'::regclass,'Code','varchar(100)',null,false,false,ARRAY['BASEDSP: false', 'GROUP: ']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"ConfigurationItems"'::regclass,'Code','varchar(100)',null,false,false,ARRAY['BASEDSP: false', 'GROUP: ']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"ConfigurationItems"'::regclass,'Description','varchar(250)',null,false,false,ARRAY['DESCR: Property', 'GROUP: ']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"ConfigurationItems"'::regclass,'Code','varchar(100)',null,false,false,ARRAY['CLASSORDER: 0']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"ConfigurationItems"'::regclass,'Description','varchar(250)',null,false,false,ARRAY['CLASSORDER: 0']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"ConfigurationItems"'::regclass,'Notes','text',null,false,false,ARRAY['CLASSORDER: 0']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"ConfigurationItems"'::regclass,'Value','varchar(150)',null,false,false,ARRAY['CLASSORDER: 0']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"ConfigurationItems"'::regclass,'Description','varchar(250)',null,false,false,ARRAY['INDEX: 3']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"DeployableUnit"'::regclass,'Code','varchar(100)',null,false,false,ARRAY['BASEDSP: false', 'GROUP: ']::text[],ARRAY[]::text[]);
SELECT * FROM cm_modify_attribute('"DeployableUnit"'::regclass,'ComponentType','int4',null,false,false,ARRAY['LOOKUP: ComponentType', 'INDEX: 4']::text[],ARRAY[]::text[]);
-- fix! SELECT * FROM cm_modify_attribute('"DeployableUnit"'::regclass,'FunctionalComponent','int4',null,false,false,ARRAY['REFERENCEDOM: FunctionalComponentToDeployableUnit', 'REFERENCEDIRECT: false', 'REFERENCETYPE: restrict', 'INDEX: 5']::text[],ARRAY[]::text[]);

-- Some Data
-- FunctionalComponents
INSERT INTO "FunctionalComponent" ("IdClass", "Code", "Description", "Status", "User", "BeginDate", "Notes") VALUES
  (E'\"FunctionalComponent\"', NULL, 'teptb-1.0.0', 'A', 'admin', '2016-02-04 14:42:00', NULL);

-- Environment
INSERT INTO "Environment" ("IdClass", "Code", "Description", "Status", "User", "BeginDate", "Notes", "Scope") VALUES
  (E'\"Environment\"', 'AU', 'AbnahmeUmgebung', 'A', 'admin', '2016-02-04 15:28:22', NULL, 'Abnahme'),
  (E'\"Environment\"', 'PU', 'ProduktionsUmgebung', 'A', 'admin', '2016-02-04 15:28:38', NULL, 'Produktion'),
  (E'\"Environment\"', 'TU', 'TestUmgebung', 'A', 'admin', '2016-02-04 15:28:48', NULL, 'Test'),
  (E'\"Environment\"', 'CI', 'CI Umgebung', 'A', 'admin', '2016-02-04 15:29:17', NULL, 'Development');

-- Data for ComponentTypes
INSERT INTO "ComponentType" ("IdClass", "Code", "Description", "Status", "User", "BeginDate", "Notes") VALUES
  (E'\"ComponentType\"', 'AMXApplication', 'AMX Application', 'A', 'admin', '2016-02-08 09:17:02', NULL),
  (E'\"ComponentType\"', 'BWApplication', 'BW Application', 'A', 'admin', '2016-02-08 09:17:02', NULL),
  (E'\"ComponentType\"', 'DatabasePackage', 'Database Package', 'A', 'admin', '2016-02-08 09:17:02', NULL),
  (E'\"ComponentType\"', 'CentraSiteVirtualService', 'CentraSite Virtual Service', 'A', 'admin', '2016-02-08 09:17:02', NULL),
  (E'\"ComponentType\"', 'WebMethodsApplication', 'WebMethods Application', 'A', 'admin', '2016-02-08 09:17:02', NULL),
  (E'\"ComponentType\"', 'EMSDestination', 'EMS Destination', 'A', 'admin', '2016-02-08 09:17:43', NULL);
