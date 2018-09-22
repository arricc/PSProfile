@StoragePath
Feature: Automatically Calculate Local Storage Paths
    In order for module settings to survive upgrades
    A PowerShell Module Author
    Needs a place outside their module to save settings
    For developer guidelines, see: http://msdn.microsoft.com/en-us/library/windows/apps/hh465094.aspx
    We create a module-specific storage location inside the operating-system specified data paths:
    By default, we store in the $Env:AppData user roaming path that Windows synchronizes (C:/Users/USERNAME/AppData/Roaming)
    But we  support using the $Env:ProgramData machine-local path instead (C:/ProgramData)
    As well as the machine-specific $Env:LocalAppData user data path (C:/Users/USERNAME/AppData/Local)

    Background:
        Given the configuration module is imported with testing paths:
        | Enterprise                | User                | Machine                |
        | TestDrive:/EnterprisePath | TestDrive:/UserPath | TestDrive:/MachinePath |

    @Scripts
    Scenario: Scripts will fail unless they specify the names
         Given a script with the name 'SuperTestScript' that calls Get-ConfigurationPath with no parameters
         Then the script should throw an exception
         Given a script with the name 'SuperTestScript' that calls Get-ConfigurationPath -Name TestScript -Author Author
         Then the script's Enterprise path should match '^TestDrive:/EnterprisePath/' and 'Author/TestScript'

    @Modules
    Scenario Outline: Modules storage paths work at load time
        Given a module with the name 'SimpleTest' by the author 'Joel Bennett'
        Then the module's user path at load time should match '^TestDrive:/UserPath/' and '/Joel Bennett/SimpleTest$'
        And the module's user path should exist already

    @Modules
    Scenario Outline: Modules get automatic storage paths
        Given a module with the name '<modulename>' by the author 'Joel Bennett'
        Then the module's Enterprise path should match '^TestDrive:/EnterprisePath/' and '/Joel Bennett/<modulename>$'
        And the module's Enterprise path should exist already
        """
        There is a <modulename>
        """

        Examples: A few different module names
            | modulename        |
            | SuperTestModule   |
            | AnotherTestModule |
            | ThirdModuleName   |

    @Modules
    Scenario Outline: Modules get automatic storage paths on Linux
        Given a module with the name '<modulename>' by the author 'Joel Bennett'
        Then the module's Enterprise path should match '^TestDrive:/EnterprisePath/' and '/Joel Bennett/<modulename>$'
        And the module's Enterprise path should exist already
        """
        There is a <modulename>
        """

        Examples: A few different module names
            | modulename        |
            | SuperTestModule   |
            | AnotherTestModule |
            | ThirdModuleName   |

    @Modules
    Scenario Outline: There should be a way to store settings at the Machine and User scope too
        Given a module with the name '<modulename>' with the author ''
        Then the module's <scope> path should match '^<rootpattern>' and '/AnonymousModules/<modulename>$'
        And the module's <scope> path should exist already

        Examples:
            | scope      | modulename      | rootpattern               |
            | Enterprise | SuperTestModule | TestDrive:/EnterprisePath |
            | Machine    | SuperTestModule | TestDrive:/MachinePath    |
            | User       | SuperTestModule | TestDrive:/UserPath       |

    @Modules
    Scenario Outline: To allow us to upgrade, settings should be versionable
        Given a module with the name 'SuperTestModule' by the author 'Joel'
        Then the module's Enterprise path should match '^TestDrive:/EnterprisePath/' and '/Joel/SuperTestModule$'
        But the module's storage path should end with a version number if one is passed in

    @Modules
    Scenario Outline: To support differentiation, settings should support a company name instead
        Given a module with the name 'SuperTestModule' by the company 'PoshCode' and the author 'Jaykul'
        Then the module's Enterprise path should match '^TestDrive:/EnterprisePath/' and '/PoshCode/SuperTestModule$'
        And the module's storage path should end with a version number if one is passed in

    @Modules @EndUsers
    Scenario: End users should be able to find the storage path for a module
        Given a module with the name 'SuperTestModule' by the company 'PoshCode' and the author 'Jaykul'
        When the ModuleInfo is piped to Get-ConfigurationPath
        Then the resulting path should match '^TestDrive:/EnterprisePath/' and '/PoshCode/SuperTestModule$'
