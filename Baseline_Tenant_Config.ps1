# Generated with Microsoft365DSC version 1.22.126.1
# For additional information on how to use Microsoft365DSC, please visit https://aka.ms/M365DSC
param (
    [parameter()]
    [System.Management.Automation.PSCredential]
    $Credential
)

Configuration runbook_2022-Feb-10-0802AM
{
    param (
        [parameter()]
        [System.Management.Automation.PSCredential]
        $Credential
    )

    if ($null -eq $Credential)
    {
        <# Credentials #>
        $Credscredential = Get-Credential -Message "Credentials"

    }
    else
    {
        $CredsCredential = $Credential
    }

    $OrganizationName = $CredsCredential.UserName.Split('@')[1]
    Import-DscResource -ModuleName 'Microsoft365DSC' -ModuleVersion '1.22.126.1'

    Node localhost
    {
        EXOAcceptedDomain 030d6550-44f0-489f-be55-86db9567ee08
        {
            Credential           = $Credscredential;
            DomainType           = "Authoritative";
            Ensure               = "Present";
            Identity             = "$OrganizationName";
            MatchSubDomains      = $False;
            OutboundOnly         = $False;
        }
        EXOAntiPhishPolicy aeddd796-3a44-432b-b145-b82db64e399b
        {
            AdminDisplayName                              = "";
            AuthenticationFailAction                      = "MoveToJmf";
            Credential                                    = $Credscredential;
            Enabled                                       = $True;
            EnableFirstContactSafetyTips                  = $False;
            EnableMailboxIntelligence                     = $True;
            EnableMailboxIntelligenceProtection           = $False;
            EnableOrganizationDomainsProtection           = $False;
            EnableSimilarDomainsSafetyTips                = $False;
            EnableSimilarUsersSafetyTips                  = $False;
            EnableSpoofIntelligence                       = $True;
            EnableTargetedDomainsProtection               = $False;
            EnableTargetedUserProtection                  = $False;
            EnableUnauthenticatedSender                   = $True;
            EnableUnusualCharactersSafetyTips             = $False;
            EnableViaTag                                  = $True;
            Ensure                                        = "Present";
            ExcludedDomains                               = @();
            ExcludedSenders                               = @();
            Identity                                      = "Office365 AntiPhish Default";
            ImpersonationProtectionState                  = "Automatic";
            MailboxIntelligenceProtectionAction           = "NoAction";
            MailboxIntelligenceProtectionActionRecipients = @();
            MakeDefault                                   = $True;
            PhishThresholdLevel                           = 1;
            TargetedDomainActionRecipients                = @();
            TargetedDomainsToProtect                      = @();
            TargetedUserActionRecipients                  = @();
            TargetedUserProtectionAction                  = "NoAction";
            TargetedUsersToProtect                        = @();
        }
        EXOAtpPolicyForO365 64d926b8-e3be-42f4-94bd-c61be3a0a23e
        {
            AllowClickThrough             = $False;
            AllowSafeDocsOpen             = $False;
            BlockUrls                     = @();
            Credential                    = $Credscredential;
            EnableATPForSPOTeamsODB       = $False;
            EnableSafeDocs                = $False;
            EnableSafeLinksForO365Clients = $True;
            Ensure                        = "Present";
            Identity                      = "$OrganizationName\Default";
            IsSingleInstance              = "Yes";
            TrackClicks                   = $False;
        }
        EXOCASMailboxPlan bc49d65e-cdcd-4ac9-90de-8d5c0fe71b5f
        {
            ActiveSyncEnabled    = $True;
            Credential           = $Credscredential;
            Ensure               = "Present";
            Identity             = "ExchangeOnlineEssentials-3f9e040e-a376-43bb-853e-26c174d91c53";
            ImapEnabled          = $True;
            OwaMailboxPolicy     = "OwaMailboxPolicy-Default";
            PopEnabled           = $True;
        }
        EXOCASMailboxPlan 07ae447d-e7a9-4ed1-90bb-ddd6ee714f15
        {
            ActiveSyncEnabled    = $True;
            Credential           = $Credscredential;
            Ensure               = "Present";
            Identity             = "ExchangeOnlineEnterprise-0fc7cbaa-b8a6-421a-8ad9-db4159cdc08a";
            ImapEnabled          = $True;
            OwaMailboxPolicy     = "OwaMailboxPolicy-Default";
            PopEnabled           = $True;
        }
        EXOCASMailboxPlan 130f4975-3701-4694-8c97-ced3a270f150
        {
            ActiveSyncEnabled    = $True;
            Credential           = $Credscredential;
            Ensure               = "Present";
            Identity             = "ExchangeOnlineDeskless-ca428015-75ab-43d8-80a3-602b39386bfb";
            ImapEnabled          = $False;
            OwaMailboxPolicy     = "OwaMailboxPolicy-Default";
            PopEnabled           = $True;
        }
        EXOCASMailboxPlan b4a2c0a7-96f7-4ded-8977-8a400ae41ac7
        {
            ActiveSyncEnabled    = $True;
            Credential           = $Credscredential;
            Ensure               = "Present";
            Identity             = "ExchangeOnline-89e45177-7e05-4e57-9114-c637500f999b";
            ImapEnabled          = $True;
            OwaMailboxPolicy     = "OwaMailboxPolicy-Default";
            PopEnabled           = $True;
        }
        EXOEmailAddressPolicy 2403b512-8e6d-41a0-bf35-c571227e065b
        {
            Credential                        = $Credscredential;
            EnabledEmailAddressTemplates      = @("SMTP:@$OrganizationName");
            EnabledPrimarySMTPAddressTemplate = "@$OrganizationName";
            Ensure                            = "Present";
            ManagedByFilter                   = "";
            Name                              = "Default Policy";
            Priority                          = "Lowest";
        }
        EXOHostedConnectionFilterPolicy 645e4469-1bf3-4ad6-9869-91a9df81fc50
        {
            AdminDisplayName     = "";
            Credential           = $Credscredential;
            EnableSafeList       = $False;
            Ensure               = "Present";
            Identity             = "Default";
            IPAllowList          = @();
            IPBlockList          = @();
            MakeDefault          = $False;
        }
        EXOHostedContentFilterPolicy 8f9f0110-b0ff-4329-920c-f7567ff32fc8
        {
            AddXHeaderValue                      = "";
            AdminDisplayName                     = "";
            BulkSpamAction                       = "MoveToJmf";
            BulkThreshold                        = 7;
            Credential                           = $Credscredential;
            DownloadLink                         = $False;
            EnableEndUserSpamNotifications       = $False;
            EnableLanguageBlockList              = $False;
            EnableRegionBlockList                = $False;
            EndUserSpamNotificationCustomSubject = "";
            EndUserSpamNotificationFrequency     = 3;
            EndUserSpamNotificationLanguage      = "Default";
            Ensure                               = "Present";
            HighConfidencePhishAction            = "Quarantine";
            HighConfidenceSpamAction             = "MoveToJmf";
            Identity                             = "Default";
            IncreaseScoreWithBizOrInfoUrls       = "Off";
            IncreaseScoreWithImageLinks          = "Off";
            IncreaseScoreWithNumericIps          = "Off";
            IncreaseScoreWithRedirectToOtherPort = "Off";
            InlineSafetyTipsEnabled              = $True;
            LanguageBlockList                    = @();
            MakeDefault                          = $True;
            MarkAsSpamBulkMail                   = "On";
            MarkAsSpamEmbedTagsInHtml            = "Off";
            MarkAsSpamEmptyMessages              = "Off";
            MarkAsSpamFormTagsInHtml             = "Off";
            MarkAsSpamFramesInHtml               = "Off";
            MarkAsSpamFromAddressAuthFail        = "Off";
            MarkAsSpamJavaScriptInHtml           = "Off";
            MarkAsSpamNdrBackscatter             = "Off";
            MarkAsSpamObjectTagsInHtml           = "Off";
            MarkAsSpamSensitiveWordList          = "Off";
            MarkAsSpamSpfRecordHardFail          = "Off";
            MarkAsSpamWebBugsInHtml              = "Off";
            ModifySubjectValue                   = "";
            PhishSpamAction                      = "MoveToJmf";
            PhishZapEnabled                      = $True;
            QuarantineRetentionPeriod            = 15;
            RedirectToRecipients                 = @();
            RegionBlockList                      = @();
            SpamAction                           = "MoveToJmf";
            SpamZapEnabled                       = $True;
            TestModeAction                       = "None";
            TestModeBccToRecipients              = @();
        }
        EXOHostedOutboundSpamFilterPolicy 72d9cbdb-6a44-4bd4-a465-9314644b098d
        {
            ActionWhenThresholdReached                = "BlockUserForToday";
            AdminDisplayName                          = "";
            AutoForwardingMode                        = "Automatic";
            BccSuspiciousOutboundAdditionalRecipients = @();
            BccSuspiciousOutboundMail                 = $False;
            Credential                                = $Credscredential;
            Ensure                                    = "Present";
            Identity                                  = "Default";
            NotifyOutboundSpam                        = $False;
            NotifyOutboundSpamRecipients              = @();
            RecipientLimitExternalPerHour             = 0;
            RecipientLimitInternalPerHour             = 0;
            RecipientLimitPerDay                      = 0;
        }
        EXOMailTips 0944776a-c3fa-41b7-a5b3-a7882e4ab4cc
        {
            Credential                            = $Credscredential;
            Ensure                                = "Present";
            MailTipsAllTipsEnabled                = $True;
            MailTipsExternalRecipientsTipsEnabled = $False;
            MailTipsGroupMetricsEnabled           = $True;
            MailTipsLargeAudienceThreshold        = 25;
            MailTipsMailboxSourcedTipsEnabled     = $True;
            Organization                          = "$OrganizationName";
        }
        EXOMalwareFilterPolicy 93e032fb-3efa-4647-b780-f8b83bb150b8
        {
            Action                                 = "DeleteMessage";
            Credential                             = $Credscredential;
            CustomNotifications                    = $False;
            EnableExternalSenderAdminNotifications = $False;
            EnableExternalSenderNotifications      = $False;
            EnableFileFilter                       = $False;
            EnableInternalSenderAdminNotifications = $False;
            EnableInternalSenderNotifications      = $False;
            Ensure                                 = "Present";
            FileTypes                              = @("ace","ani","app","cab","docm","exe","iso","jar","jnlp","reg","scr","vbe","vbs");
            Identity                               = "Default";
            MakeDefault                            = $True;
            ZapEnabled                             = $True;
        }
        EXOMobileDeviceMailboxPolicy 05357560-9b55-409b-87cc-45a35cd0bd56
        {
            AllowApplePushNotifications              = $True;
            AllowBluetooth                           = "Allow";
            AllowBrowser                             = $True;
            AllowCamera                              = $True;
            AllowConsumerEmail                       = $True;
            AllowDesktopSync                         = $True;
            AllowExternalDeviceManagement            = $False;
            AllowGooglePushNotifications             = $True;
            AllowHTMLEmail                           = $True;
            AllowInternetSharing                     = $True;
            AllowIrDA                                = $True;
            AllowMicrosoftPushNotifications          = $True;
            AllowMobileOTAUpdate                     = $True;
            AllowNonProvisionableDevices             = $True;
            AllowPOPIMAPEmail                        = $True;
            AllowRemoteDesktop                       = $True;
            AllowSimplePassword                      = $True;
            AllowSMIMEEncryptionAlgorithmNegotiation = "AllowAnyAlgorithmNegotiation";
            AllowSMIMESoftCerts                      = $True;
            AllowStorageCard                         = $True;
            AllowTextMessaging                       = $True;
            AllowUnsignedApplications                = $True;
            AllowUnsignedInstallationPackages        = $True;
            AllowWiFi                                = $True;
            AlphanumericPasswordRequired             = $False;
            ApprovedApplicationList                  = @();
            AttachmentsEnabled                       = $True;
            Credential                               = $Credscredential;
            DeviceEncryptionEnabled                  = $False;
            DevicePolicyRefreshInterval              = "Unlimited";
            Ensure                                   = "Present";
            IrmEnabled                               = $True;
            IsDefault                                = $True;
            MaxAttachmentSize                        = "Unlimited";
            MaxCalendarAgeFilter                     = "All";
            MaxEmailAgeFilter                        = "All";
            MaxEmailBodyTruncationSize               = "Unlimited";
            MaxEmailHTMLBodyTruncationSize           = "Unlimited";
            MaxInactivityTimeLock                    = "Unlimited";
            MaxPasswordFailedAttempts                = "Unlimited";
            MinPasswordComplexCharacters             = 1;
            Name                                     = "Default";
            PasswordEnabled                          = $False;
            PasswordExpiration                       = "Unlimited";
            PasswordHistory                          = 0;
            PasswordRecoveryEnabled                  = $False;
            RequireDeviceEncryption                  = $False;
            RequireEncryptedSMIMEMessages            = $False;
            RequireEncryptionSMIMEAlgorithm          = "TripleDES";
            RequireManualSyncWhenRoaming             = $False;
            RequireSignedSMIMEAlgorithm              = "SHA1";
            RequireSignedSMIMEMessages               = $False;
            RequireStorageCardEncryption             = $False;
            UnapprovedInROMApplicationList           = @();
            UNCAccessEnabled                         = $True;
            WSSAccessEnabled                         = $True;
        }
        EXOOrganizationConfig effbf603-8202-4b88-b9df-ca3d565be737
        {
            ActivityBasedAuthenticationTimeoutEnabled                 = $True;
            ActivityBasedAuthenticationTimeoutInterval                = "06:00:00";
            ActivityBasedAuthenticationTimeoutWithSingleSignOnEnabled = $True;
            AppsForOfficeEnabled                                      = $True;
            AsyncSendEnabled                                          = $True;
            AuditDisabled                                             = $False;
            AutoExpandingArchive                                      = $False;
            BookingsEnabled                                           = $True;
            BookingsPaymentsEnabled                                   = $False;
            BookingsSocialSharingRestricted                           = $False;
            ByteEncoderTypeFor7BitCharsets                            = 0;
            ConnectorsActionableMessagesEnabled                       = $True;
            ConnectorsEnabled                                         = $True;
            ConnectorsEnabledForOutlook                               = $True;
            ConnectorsEnabledForSharepoint                            = $True;
            ConnectorsEnabledForTeams                                 = $True;
            ConnectorsEnabledForYammer                                = $True;
            Credential                                                = $Credscredential;
            DefaultAuthenticationPolicy                               = "Allow-BasicAuth";
            DefaultGroupAccessType                                    = "Private";
            DefaultPublicFolderDeletedItemRetention                   = "30.00:00:00";
            DefaultPublicFolderIssueWarningQuota                      = "1.7 GB (1,825,361,920 bytes)";
            DefaultPublicFolderMaxItemSize                            = "Unlimited";
            DefaultPublicFolderMovedItemRetention                     = "7.00:00:00";
            DefaultPublicFolderProhibitPostQuota                      = "2 GB (2,147,483,648 bytes)";
            DirectReportsGroupAutoCreationEnabled                     = $False;
            DistributionGroupNameBlockedWordsList                     = @();
            DistributionGroupNamingPolicy                             = "";
            ElcProcessingDisabled                                     = $False;
            EndUserDLUpgradeFlowsDisabled                             = $False;
            ExchangeNotificationEnabled                               = $True;
            ExchangeNotificationRecipients                            = @();
            IPListBlocked                                             = @();
            IsSingleInstance                                          = "Yes";
            LeanPopoutEnabled                                         = $False;
            LinkPreviewEnabled                                        = $True;
            MailTipsAllTipsEnabled                                    = $True;
            MailTipsExternalRecipientsTipsEnabled                     = $False;
            MailTipsGroupMetricsEnabled                               = $True;
            MailTipsLargeAudienceThreshold                            = 25;
            MailTipsMailboxSourcedTipsEnabled                         = $True;
            OAuth2ClientProfileEnabled                                = $True;
            OutlookMobileGCCRestrictionsEnabled                       = $False;
            OutlookPayEnabled                                         = $True;
            PublicComputersDetectionEnabled                           = $False;
            PublicFoldersEnabled                                      = "Local";
            PublicFolderShowClientControl                             = $False;
            ReadTrackingEnabled                                       = $False;
            RemotePublicFolderMailboxes                               = @();
            SendFromAliasEnabled                                      = $False;
            SmtpActionableMessagesEnabled                             = $True;
            VisibleMeetingUpdateProperties                            = "Location,AllProperties:15";
            WebPushNotificationsDisabled                              = $False;
            WebSuggestedRepliesDisabled                               = $False;
        }
        EXOOwaMailboxPolicy 468b2273-01c1-482f-891a-8068604d4b5a
        {
            ActionForUnknownFileAndMIMETypes                     = "Allow";
            ActiveSyncIntegrationEnabled                         = $True;
            AdditionalStorageProvidersAvailable                  = $True;
            AllAddressListsEnabled                               = $True;
            AllowCopyContactsToDeviceAddressBook                 = $True;
            AllowedFileTypes                                     = @(".rpmsg",".xlsx",".xlsm",".xlsb",".vstx",".vstm",".vssx",".vssm",".vsdx",".vsdm",".tiff",".pptx",".pptm",".ppsx",".ppsm",".docx",".docm",".zip",".xls",".wmv",".wma",".wav",".vtx",".vsx",".vst",".vss",".vsd",".vdx",".txt",".tif",".rtf",".pub",".ppt",".png",".pdf",".one",".mp3",".jpg",".gif",".doc",".csv",".bmp",".avi");
            AllowedMimeTypes                                     = @("image/jpeg","image/png","image/gif","image/bmp");
            BlockedFileTypes                                     = @(".settingcontent-ms",".printerexport",".appcontent-ms",".appref-ms",".vsmacros",".website",".msh2xml",".msh1xml",".diagcab",".webpnp",".ps2xml",".ps1xml",".mshxml",".gadget",".theme",".psdm1",".mhtml",".cdxml",".xbap",".vhdx",".pyzw",".pssc",".psd1",".psc2",".psc1",".msh2",".msh1",".jnlp",".aspx",".appx",".xnk",".xll",".wsh",".wsf",".wsc",".wsb",".vsw",".vhd",".vbs",".vbp",".vbe",".url",".udl",".tmp",".shs",".shb",".sct",".scr",".scf",".reg",".pyz",".pyw",".pyo",".pyc",".pst",".ps2",".ps1",".prg",".prf",".plg",".pif",".pcd",".osd",".ops",".msu",".mst",".msp",".msi",".msh",".msc",".mht",".mdz",".mdw",".mdt",".mde",".mdb",".mda",".mcf",".maw",".mav",".mau",".mat",".mas",".mar",".maq",".mam",".mag",".maf",".mad",".lnk",".ksh",".jse",".jar",".its",".isp",".ins",".inf",".htc",".hta",".hpj",".hlp",".grp",".fxp",".exe",".der",".csh",".crt",".cpl",".com",".cnt",".cmd",".chm",".cer",".bat",".bas",".asx",".asp",".app",".apk",".adp",".ade",".ws",".vb",".py",".pl",".js");
            BlockedMimeTypes                                     = @("application/x-javascript","application/javascript","application/msaccess","x-internet-signup","text/javascript","application/prg","application/hta","text/scriplet");
            ClassicAttachmentsEnabled                            = $True;
            ConditionalAccessPolicy                              = "Off";
            Credential                                           = $Credscredential;
            DefaultTheme                                         = "";
            DirectFileAccessOnPrivateComputersEnabled            = $True;
            DirectFileAccessOnPublicComputersEnabled             = $True;
            DisplayPhotosEnabled                                 = $True;
            Ensure                                               = "Present";
            ExplicitLogonEnabled                                 = $True;
            ExternalImageProxyEnabled                            = $True;
            ForceSaveAttachmentFilteringEnabled                  = $False;
            ForceSaveFileTypes                                   = @(".svgz",".html",".xml",".swf",".svg",".spl",".htm",".dir",".dcr");
            ForceSaveMimeTypes                                   = @("Application/x-shockwave-flash","Application/octet-stream","Application/futuresplash","Application/x-director","application/xml","image/svg+xml","text/html","text/xml");
            ForceWacViewingFirstOnPrivateComputers               = $False;
            ForceWacViewingFirstOnPublicComputers                = $False;
            FreCardsEnabled                                      = $True;
            GlobalAddressListEnabled                             = $True;
            GroupCreationEnabled                                 = $True;
            InstantMessagingEnabled                              = $True;
            InstantMessagingType                                 = "Ocs";
            InterestingCalendarsEnabled                          = $True;
            IRMEnabled                                           = $True;
            IsDefault                                            = $True;
            JournalEnabled                                       = $True;
            LocalEventsEnabled                                   = $False;
            LogonAndErrorLanguage                                = 0;
            Name                                                 = "OwaMailboxPolicy-Default";
            NotesEnabled                                         = $True;
            NpsSurveysEnabled                                    = $True;
            OnSendAddinsEnabled                                  = $False;
            OrganizationEnabled                                  = $True;
            OutboundCharset                                      = "AutoDetect";
            OutlookBetaToggleEnabled                             = $True;
            OWALightEnabled                                      = $True;
            PersonalAccountCalendarsEnabled                      = $True;
            PhoneticSupportEnabled                               = $False;
            PlacesEnabled                                        = $True;
            PremiumClientEnabled                                 = $True;
            PrintWithoutDownloadEnabled                          = $True;
            PublicFoldersEnabled                                 = $True;
            RecoverDeletedItemsEnabled                           = $True;
            ReferenceAttachmentsEnabled                          = $True;
            RemindersAndNotificationsEnabled                     = $True;
            ReportJunkEmailEnabled                               = $True;
            RulesEnabled                                         = $True;
            SatisfactionEnabled                                  = $True;
            SaveAttachmentsToCloudEnabled                        = $True;
            SearchFoldersEnabled                                 = $True;
            SetPhotoEnabled                                      = $True;
            SetPhotoURL                                          = "";
            SignaturesEnabled                                    = $True;
            SkipCreateUnifiedGroupCustomSharepointClassification = $True;
            TeamSnapCalendarsEnabled                             = $True;
            TextMessagingEnabled                                 = $True;
            ThemeSelectionEnabled                                = $True;
            UMIntegrationEnabled                                 = $True;
            UseGB18030                                           = $False;
            UseISO885915                                         = $False;
            UserVoiceEnabled                                     = $True;
            WacEditingEnabled                                    = $True;
            WacExternalServicesEnabled                           = $True;
            WacOMEXEnabled                                       = $False;
            WacViewingOnPrivateComputersEnabled                  = $True;
            WacViewingOnPublicComputersEnabled                   = $True;
            WeatherEnabled                                       = $True;
            WebPartsFrameOptionsType                             = "SameOrigin";
        }
        EXORemoteDomain b524c1d8-612b-482f-b1b6-9e2bc72da8e5
        {
            AllowedOOFType                       = "External";
            AutoForwardEnabled                   = $True;
            AutoReplyEnabled                     = $True;
            ByteEncoderTypeFor7BitCharsets       = "Undefined";
            CharacterSet                         = "iso-8859-1";
            ContentType                          = "MimeHtmlText";
            Credential                           = $Credscredential;
            DeliveryReportEnabled                = $True;
            DisplaySenderName                    = $True;
            DomainName                           = "*";
            Ensure                               = "Present";
            Identity                             = "Default";
            IsInternal                           = $False;
            LineWrapSize                         = "Unlimited";
            MeetingForwardNotificationEnabled    = $False;
            Name                                 = "Default";
            NonMimeCharacterSet                  = "iso-8859-1";
            PreferredInternetCodePageForShiftJis = "Undefined";
            TargetDeliveryDomain                 = $False;
            TrustedMailInboundEnabled            = $False;
            TrustedMailOutboundEnabled           = $False;
            UseSimpleDisplayName                 = $False;
        }
        EXORoleAssignmentPolicy 60a4287d-4fb4-4446-a7f9-ae77a06a9d5a
        {
            Credential           = $Credscredential;
            Description          = "This policy grants end users the permission to set their options in Outlook on the web and perform other self-administration tasks.";
            Ensure               = "Present";
            IsDefault            = $True;
            Name                 = "Default Role Assignment Policy";
            Roles                = @("MyRetentionPolicies","My ReadWriteMailbox Apps","My Marketplace Apps","MyDistributionGroups","MyDistributionGroupMembership","My Custom Apps","MyProfileInformation","MyContactInformation","MyVoiceMail","MyTextMessaging","MyMailSubscriptions","MyBaseOptions","MyTeamMailboxes");
        }
        EXOSafeAttachmentPolicy 3f007035-b4a0-47b8-b879-86fa2bcedbc2
        {
            Action               = "Block";
            ActionOnError        = $True;
            AdminDisplayName     = "";
            Credential           = $Credscredential;
            Enable               = $True;
            Ensure               = "Present";
            Identity             = "Built-In Protection Policy";
            Redirect             = $False;
            RedirectAddress      = "";
        }
        EXOSafeLinksPolicy b1b11a92-09c9-4d06-ac0b-adfc4bcbc029
        {
            AdminDisplayName           = "";
            Credential                 = $Credscredential;
            CustomNotificationText     = "";
            DeliverMessageAfterScan    = $True;
            DoNotAllowClickThrough     = $False;
            DoNotRewriteUrls           = @();
            DoNotTrackUserClicks       = $False;
            EnableForInternalSenders   = $True;
            EnableOrganizationBranding = $False;
            EnableSafeLinksForTeams    = $True;
            Ensure                     = "Present";
            Identity                   = "Built-In Protection Policy";
            IsEnabled                  = $True;
            ScanUrls                   = $True;
        }
        EXOSharingPolicy 2c391818-684f-42e6-9ec4-c4b17f0f94dd
        {
            Credential           = $Credscredential;
            Default              = $True;
            Domains              = @("Anonymous:CalendarSharingFreeBusyReviewer","*:CalendarSharingFreeBusySimple");
            Enabled              = $True;
            Ensure               = "Present";
            Name                 = "Default Sharing Policy";
        }
        O365AdminAuditLogConfig 616b383f-b9aa-4460-a3fa-e89fd103a0fd
        {
            Credential                      = $Credscredential;
            Ensure                          = "Present";
            IsSingleInstance                = "Yes";
            UnifiedAuditLogIngestionEnabled = "Disabled";
        }
        SCDLPCompliancePolicy 5633cfa6-a74d-4230-9ea3-fa1c659fbe69
        {
            Comment                         = "This policy detects the presence of credit card numbers in Teams chats and channel messages. When this sensitive information is detected, admins will get an Alert notification. Users would not see any policy tip. However, you can edit these actions anytime.";
            Credential                      = $Credscredential;
            Ensure                          = "Present";
            ExchangeSenderMemberOf          = @();
            ExchangeSenderMemberOfException = @();
            Mode                            = "Enable";
            Name                            = "Default policy for Teams";
            OneDriveLocationException       = @();
            Priority                        = 0;
            SharePointLocationException     = @();
            TeamsLocation                   = "All";
            TeamsLocationException          = @();
        }
        SCDLPComplianceRule 9cda8a92-1303-48de-aa90-1c425d02ea4d
        {
            BlockAccess                         = $False;
            Comment                             = "This default policy will monitor credit card details with a rule to notify the Administrator.";
            ContentContainsSensitiveInformation = MSFT_SCDLPContainsSensitiveInformation
            {
                SensitiveInformation = @(
MSFT_SCDLPSensitiveInformation
            {
                name = 'Credit Card Number'
                id = '50842eb7-edc8-4019-85dd-5a5c1f2bb085'
                maxconfidence = '100'
                minconfidence = '85'
                classifiertype = 'Content'
                mincount = '1'
                maxcount = '-1'
            }
            )            }
;
            Credential                          = $Credscredential;
            Disabled                            = $False;
            DocumentIsPasswordProtected         = $False;
            DocumentIsUnsupported               = $False;
            Ensure                              = "Present";
            ExceptIfDocumentIsPasswordProtected = $False;
            ExceptIfDocumentIsUnsupported       = $False;
            ExceptIfHasSenderOverride           = $False;
            ExceptIfProcessingLimitExceeded     = $False;
            GenerateIncidentReport              = @("SiteAdmin");
            HasSenderOverride                   = $False;
            IncidentReportContent               = @("Title","DocumentAuthor","DocumentLastModifier","Service","MatchedItem","RulesMatched","Detections","Severity","RetentionLabel","SensitivityLabel");
            Name                                = "Default Teams DLP policy rule";
            Policy                              = "Default policy for Teams";
            ProcessingLimitExceeded             = $False;
            RemoveRMSTemplate                   = $False;
            ReportSeverityLevel                 = "Low";
            StopPolicyProcessing                = $False;
        }
        SCFilePlanPropertyAuthority 989412b4-25a4-461c-8207-2cd29b070f29
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Business";
        }
        SCFilePlanPropertyAuthority 8ce805d9-fadd-4d12-a714-32fb105baec7
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Legal";
        }
        SCFilePlanPropertyAuthority d75fd719-5d24-4bd3-b2bf-c7a1389bf06b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Regulatory";
        }
        SCFilePlanPropertyCategory 126b7727-7b28-4e56-b311-a591def07477
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Accounts payable";
        }
        SCFilePlanPropertyCategory 3271d5b6-ecb2-43df-b431-e3e6b75ce23a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Accounts receivable";
        }
        SCFilePlanPropertyCategory 6b177c47-4b2d-4d05-a438-641d4947e75c
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Administration";
        }
        SCFilePlanPropertyCategory 291000f6-83eb-43be-9c71-a7bc65b83c8b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Compliance";
        }
        SCFilePlanPropertyCategory ec4e0327-9c9c-4853-9b32-d7af11ff3d02
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Contracting";
        }
        SCFilePlanPropertyCategory 602daaf0-28c8-49f9-ae51-11749811232a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Financial statements";
        }
        SCFilePlanPropertyCategory ab2affe2-4f37-4e1c-a1f7-fdedf468d669
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Learning and development";
        }
        SCFilePlanPropertyCategory b5905cd5-7c84-4986-90f3-5e5cfa382f8a
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Planning";
        }
        SCFilePlanPropertyCategory 5a1ba350-0a2c-4464-ac79-4590cb3cd5c4
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Payroll";
        }
        SCFilePlanPropertyCategory 05403c50-a720-486c-9251-d7125395a807
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Policies and procedures";
        }
        SCFilePlanPropertyCategory 861cde9c-e380-476a-ad33-60b00afbcda4
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Procurement";
        }
        SCFilePlanPropertyCategory 018cb7cf-f4b9-4b91-b186-68ab0bebd11b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Recruiting and hiring";
        }
        SCFilePlanPropertyCategory c6e2ddbf-9a2b-49ac-82a8-65e2e6e141b1
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Research and development";
        }
        SCFilePlanPropertyCitation a81c139d-f216-408c-8f1d-9828c84cb98f
        {
            CitationJurisdiction = "U.S. Futures Commodity Trading Commission (UCFTC)";
            CitationUrl          = "https://www.cftc.gov/LawRegulation/CommodityExchangeAct/index.htm";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Commodity Exchange Act";
        }
        SCFilePlanPropertyCitation 4ecbacde-7bc3-4f4e-8701-769643e0a63f
        {
            CitationJurisdiction = "U.S. Securities and Exchange Commission (SEC)";
            CitationUrl          = "https://www.sec.gov/answers/about-lawsshtml.html#sox2002";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Sarbanes-Oxley Act of 2002";
        }
        SCFilePlanPropertyCitation 69d78953-173c-4814-92c0-09dada36af2c
        {
            CitationJurisdiction = "Federal Trade Commission (FTC)";
            CitationUrl          = "https://www.ftc.gov/enforcement/statutes/truth-lending-act";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Truth in lending Act";
        }
        SCFilePlanPropertyCitation d35e6314-73a5-47ec-8480-3e78effdfa7b
        {
            CitationJurisdiction = "U.S. Department of Health & Human Services (HHS)";
            CitationUrl          = "https://aspe.hhs.gov/report/health-insurance-portability-and-accountability-act-1996";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Health Insurance Portability and Accountability Act of 1996";
        }
        SCFilePlanPropertyCitation c363e836-cc0b-4026-ae0f-cee7eee3c605
        {
            CitationJurisdiction = "U.S. Department of Labor (DOL)";
            CitationUrl          = "https://www.osha.gov/recordkeeping/index.html";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "OSHA Injury and Illness Recordkeeping and Reporting Requirements";
        }
        SCFilePlanPropertyDepartment 380894b7-2895-48c5-a3af-9730cc621ded
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Finance";
        }
        SCFilePlanPropertyDepartment 983dc501-ba83-4862-93d9-ac07c7c6fefc
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Human resources";
        }
        SCFilePlanPropertyDepartment 61f7c5a7-6dda-458c-924d-0f9a861ed6a3
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Information technology";
        }
        SCFilePlanPropertyDepartment 76f3489f-f78a-4498-9a96-ed09a6d91913
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Legal";
        }
        SCFilePlanPropertyDepartment 80abe314-44ab-4ef9-adde-a069dc283f65
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Marketing";
        }
        SCFilePlanPropertyDepartment 6cee1048-4de2-42a3-b577-6b164ae0fd00
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Operations";
        }
        SCFilePlanPropertyDepartment 7cf87a44-097a-441a-a996-70d3cffaf485
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Procurement";
        }
        SCFilePlanPropertyDepartment 653b8195-7807-4821-aa17-7871a730987b
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Products";
        }
        SCFilePlanPropertyDepartment a029fa64-50e2-4593-bdd3-45e59287d1d4
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Sales";
        }
        SCFilePlanPropertyDepartment 4937e676-40df-4dbd-bb4d-80455123bbca
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Services";
        }
        SCRetentionEventType f0ee6347-4b5a-4415-b164-e08a2dc802d4
        {
            Comment              = "Processes related to hiring, performance and termination of an employee.";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Employee activity";
        }
        SCRetentionEventType 92ce7cb6-1711-4ae7-bfee-16bac5d3a253
        {
            Comment              = "Expiration or termination of various executed contracts and agreements such as business contracts, leases, license agreements and contingent staff agreements.";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Expiration or termination of contracts and agreements";
        }
        SCRetentionEventType 96d1c24c-5732-47a5-9587-952a5a9c4212
        {
            Comment              = "Processes related to last manufacturing date of products.";
            Credential           = $Credscredential;
            Ensure               = "Present";
            Name                 = "Product lifetime";
        }
        TeamsCallingPolicy 6c65a169-c7f7-49b5-9795-dcf74a4aadaa
        {
            AllowCallForwardingToPhone        = $True;
            AllowCallForwardingToUser         = $True;
            AllowCallGroups                   = $True;
            AllowCloudRecordingForCalls       = $False;
            AllowDelegation                   = $True;
            AllowPrivateCalling               = $True;
            AllowTranscriptionForCalling      = $False;
            AllowVoicemail                    = "UserOverride";
            AllowWebPSTNCalling               = $True;
            AutoAnswerEnabledType             = "Disabled";
            BusyOnBusyEnabledType             = "Disabled";
            Credential                        = $Credscredential;
            Ensure                            = "Present";
            Identity                          = "Global";
            LiveCaptionsEnabledTypeForCalling = "DisabledUserOverride";
            MusicOnHoldEnabledType            = "Enabled";
            PreventTollBypass                 = $False;
            SafeTransferEnabled               = "Disabled";
            SpamFilteringEnabledType          = "Enabled";
        }
        TeamsCallingPolicy f9dc5500-7d91-490f-ad87-850f1c6778ca
        {
            AllowCallForwardingToPhone        = $True;
            AllowCallForwardingToUser         = $True;
            AllowCallGroups                   = $True;
            AllowCloudRecordingForCalls       = $False;
            AllowDelegation                   = $True;
            AllowPrivateCalling               = $True;
            AllowTranscriptionForCalling      = $False;
            AllowVoicemail                    = "UserOverride";
            AllowWebPSTNCalling               = $True;
            AutoAnswerEnabledType             = "Disabled";
            BusyOnBusyEnabledType             = "Disabled";
            Credential                        = $Credscredential;
            Ensure                            = "Present";
            Identity                          = "Tag:AllowCalling";
            LiveCaptionsEnabledTypeForCalling = "DisabledUserOverride";
            MusicOnHoldEnabledType            = "Enabled";
            PreventTollBypass                 = $False;
            SafeTransferEnabled               = "Disabled";
            SpamFilteringEnabledType          = "Enabled";
        }
        TeamsCallingPolicy 62a4a64d-c81e-4f74-bc59-00b59d98cbce
        {
            AllowCallForwardingToPhone        = $True;
            AllowCallForwardingToUser         = $True;
            AllowCallGroups                   = $True;
            AllowCloudRecordingForCalls       = $False;
            AllowDelegation                   = $True;
            AllowPrivateCalling               = $True;
            AllowTranscriptionForCalling      = $False;
            AllowVoicemail                    = "UserOverride";
            AllowWebPSTNCalling               = $True;
            AutoAnswerEnabledType             = "Disabled";
            BusyOnBusyEnabledType             = "Disabled";
            Credential                        = $Credscredential;
            Ensure                            = "Present";
            Identity                          = "Tag:AllowCallingPreventTollBypass";
            LiveCaptionsEnabledTypeForCalling = "DisabledUserOverride";
            MusicOnHoldEnabledType            = "Enabled";
            PreventTollBypass                 = $True;
            SafeTransferEnabled               = "Disabled";
            SpamFilteringEnabledType          = "Enabled";
        }
        TeamsCallingPolicy 347a7201-d614-4c4b-9e39-864883f53815
        {
            AllowCallForwardingToPhone        = $False;
            AllowCallForwardingToUser         = $True;
            AllowCallGroups                   = $True;
            AllowCloudRecordingForCalls       = $False;
            AllowDelegation                   = $True;
            AllowPrivateCalling               = $True;
            AllowTranscriptionForCalling      = $False;
            AllowVoicemail                    = "UserOverride";
            AllowWebPSTNCalling               = $True;
            AutoAnswerEnabledType             = "Disabled";
            BusyOnBusyEnabledType             = "Disabled";
            Credential                        = $Credscredential;
            Ensure                            = "Present";
            Identity                          = "Tag:AllowCallingPreventForwardingtoPhone";
            LiveCaptionsEnabledTypeForCalling = "DisabledUserOverride";
            MusicOnHoldEnabledType            = "Enabled";
            PreventTollBypass                 = $False;
            SafeTransferEnabled               = "Disabled";
            SpamFilteringEnabledType          = "Enabled";
        }
        TeamsCallingPolicy e817c4eb-ad0a-40c2-93f2-20b6ce4bd24e
        {
            AllowCallForwardingToPhone        = $False;
            AllowCallForwardingToUser         = $False;
            AllowCallGroups                   = $False;
            AllowCloudRecordingForCalls       = $False;
            AllowDelegation                   = $False;
            AllowPrivateCalling               = $False;
            AllowTranscriptionForCalling      = $False;
            AllowVoicemail                    = "AlwaysDisabled";
            AllowWebPSTNCalling               = $True;
            AutoAnswerEnabledType             = "Disabled";
            BusyOnBusyEnabledType             = "Disabled";
            Credential                        = $Credscredential;
            Ensure                            = "Present";
            Identity                          = "Tag:DisallowCalling";
            LiveCaptionsEnabledTypeForCalling = "DisabledUserOverride";
            MusicOnHoldEnabledType            = "Enabled";
            PreventTollBypass                 = $False;
            SafeTransferEnabled               = "Disabled";
            SpamFilteringEnabledType          = "Enabled";
        }
        TeamsChannelsPolicy 214c5863-61dd-4587-9e3a-ae3d0eb0a4c2
        {
            AllowChannelSharingToExternalUser             = $True;
            AllowOrgWideTeamCreation                      = $True;
            AllowPrivateChannelCreation                   = $True;
            AllowPrivateTeamDiscovery                     = $True;
            AllowSharedChannelCreation                    = $True;
            AllowUserToParticipateInExternalSharedChannel = $True;
            Credential                                    = $Credscredential;
            Ensure                                        = "Present";
            Identity                                      = "Global";
        }
        TeamsChannelsPolicy 6a71f6d9-1acc-4119-a609-b797c9406532
        {
            AllowChannelSharingToExternalUser             = $True;
            AllowOrgWideTeamCreation                      = $True;
            AllowPrivateChannelCreation                   = $True;
            AllowPrivateTeamDiscovery                     = $True;
            AllowSharedChannelCreation                    = $True;
            AllowUserToParticipateInExternalSharedChannel = $True;
            Credential                                    = $Credscredential;
            Ensure                                        = "Present";
            Identity                                      = "Tag:Default";
        }
        TeamsClientConfiguration 1e50c766-3157-41da-a2c9-5a023a938496
        {
            AllowBox                         = $True;
            AllowDropBox                     = $True;
            AllowEgnyte                      = $True;
            AllowEmailIntoChannel            = $True;
            AllowGoogleDrive                 = $True;
            AllowGuestUser                   = $True;
            AllowOrganizationTab             = $True;
            AllowResourceAccountSendMessage  = $True;
            AllowScopedPeopleSearchandAccess = $False;
            AllowShareFile                   = $True;
            AllowSkypeBusinessInterop        = $True;
            ContentPin                       = "RequiredOutsideScheduleMeeting";
            Credential                       = $Credscredential;
            Identity                         = "Global";
            ResourceAccountContentAccess     = "NoAccess";
        }
        TeamsEmergencyCallingPolicy 5dc25cc4-fef8-420f-af8a-1b6529778b5f
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Identity             = "Global";
        }
        TeamsEmergencyCallRoutingPolicy 87487228-11c6-4423-9fb5-2de8582868e7
        {
            AllowEnhancedEmergencyServices = $False;
            Credential                     = $Credscredential;
            Ensure                         = "Present";
            Identity                       = "Global";
        }
        TeamsGuestCallingConfiguration 6f71c86b-8d02-4d21-9af7-5db472e3cb87
        {
            AllowPrivateCalling  = $True;
            Credential           = $Credscredential;
            Identity             = "Global";
        }
        TeamsGuestMeetingConfiguration b77e3606-8330-4b88-afae-0f7077ed33a8
        {
            AllowIPVideo         = $True;
            AllowMeetNow         = $True;
            Credential           = $Credscredential;
            Identity             = "Global";
            ScreenSharingMode    = "EntireScreen";
        }
        TeamsGuestMessagingConfiguration 4ca369df-50b8-42d7-9f6f-59a56102be0b
        {
            AllowGiphy             = $True;
            AllowImmersiveReader   = $True;
            AllowMemes             = $True;
            AllowStickers          = $True;
            AllowUserChat          = $True;
            AllowUserDeleteMessage = $True;
            AllowUserEditMessage   = $True;
            Credential             = $Credscredential;
            GiphyRatingType        = "Moderate";
            Identity               = "Global";
        }
        TeamsMeetingBroadcastConfiguration d12a0cc7-e19a-4c7a-a62a-529fac951146
        {
            AllowSdnProviderForBroadcastMeeting = $False;
            Credential                          = $Credscredential;
            Identity                            = "Global";
            SdnApiTemplateUrl                   = "";
            SdnApiToken                         = "$ConfigurationData.Settings.SdnApiToken";
            SdnLicenseId                        = "";
            SdnProviderName                     = "";
            SupportURL                          = "https://support.office.com/home/contact";
        }
        TeamsMeetingBroadcastPolicy 19746c7e-d252-4f7c-8857-abbef52bb35c
        {
            AllowBroadcastScheduling        = $True;
            AllowBroadcastTranscription     = $False;
            BroadcastAttendeeVisibilityMode = "EveryoneInCompany";
            BroadcastRecordingMode          = "AlwaysEnabled";
            Credential                      = $Credscredential;
            Ensure                          = "Present";
            Identity                        = "Global";
        }
        TeamsMeetingBroadcastPolicy febd8ac9-b20d-4c89-a724-9c302bfd437f
        {
            AllowBroadcastScheduling        = $True;
            AllowBroadcastTranscription     = $False;
            BroadcastAttendeeVisibilityMode = "EveryoneInCompany";
            BroadcastRecordingMode          = "AlwaysEnabled";
            Credential                      = $Credscredential;
            Ensure                          = "Present";
            Identity                        = "Tag:Default";
        }
        TeamsMeetingConfiguration 0e4380c2-780d-4791-a013-3be7c61e898c
        {
            ClientAppSharingPort        = 50040;
            ClientAppSharingPortRange   = 20;
            ClientAudioPort             = 50000;
            ClientAudioPortRange        = 20;
            ClientMediaPortRangeEnabled = $True;
            ClientVideoPort             = 50020;
            ClientVideoPortRange        = 20;
            Credential                  = $Credscredential;
            DisableAnonymousJoin        = $False;
            EnableQoS                   = $False;
            Identity                    = "Global";
        }
        TeamsMeetingPolicy 03b358e9-4110-4fe9-b9c6-9766bbc0fd05
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $True;
            AllowCloudRecording                        = $True;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $True;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $True;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $True;
            AllowParticipantGiveRequestControl         = $True;
            AllowPowerPointSharing                     = $True;
            AllowPrivateMeetingScheduling              = $True;
            AllowPrivateMeetNow                        = $True;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $True;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $True;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            Credential                                 = $Credscredential;
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            Identity                                   = "Global";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "DisabledUserOverride";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Enabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "OneDriveForBusiness";
            ScreenSharingMode                          = "EntireScreen";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
            WhoCanRegister                             = "Everyone";
        }
        TeamsMeetingPolicy e46ef978-b0e0-455b-ba67-2d6705e9bf29
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $True;
            AllowCloudRecording                        = $True;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $True;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $True;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $True;
            AllowParticipantGiveRequestControl         = $True;
            AllowPowerPointSharing                     = $True;
            AllowPrivateMeetingScheduling              = $True;
            AllowPrivateMeetNow                        = $True;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $True;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $True;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            Credential                                 = $Credscredential;
            Description                                = "Do not assign. This policy is same as global defaults and would be deprecated";
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            Identity                                   = "Tag:AllOn";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "DisabledUserOverride";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Enabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "OneDriveForBusiness";
            ScreenSharingMode                          = "EntireScreen";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
            WhoCanRegister                             = "Everyone";
        }
        TeamsMeetingPolicy 5b15f740-209a-4898-bbf6-7939435ecbc6
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $True;
            AllowCloudRecording                        = $True;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $True;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $True;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $True;
            AllowParticipantGiveRequestControl         = $True;
            AllowPowerPointSharing                     = $True;
            AllowPrivateMeetingScheduling              = $True;
            AllowPrivateMeetNow                        = $True;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $True;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $True;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            Credential                                 = $Credscredential;
            Description                                = "Do not assign. This policy is same as global defaults and would be deprecated";
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            Identity                                   = "Tag:RestrictedAnonymousAccess";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "Disabled";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Enabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "OneDriveForBusiness";
            ScreenSharingMode                          = "EntireScreen";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
            WhoCanRegister                             = "Everyone";
        }
        TeamsMeetingPolicy 3dcbd1bc-d197-407e-9189-522ba068a112
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $False;
            AllowCloudRecording                        = $False;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $False;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $False;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $False;
            AllowParticipantGiveRequestControl         = $False;
            AllowPowerPointSharing                     = $False;
            AllowPrivateMeetingScheduling              = $False;
            AllowPrivateMeetNow                        = $False;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $False;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $False;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            Credential                                 = $Credscredential;
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            Identity                                   = "Tag:AllOff";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "Disabled";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Disabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "OneDriveForBusiness";
            ScreenSharingMode                          = "Disabled";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
            WhoCanRegister                             = "Everyone";
        }
        TeamsMeetingPolicy 9af953fc-beef-44f6-ad79-17fa550f2db7
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $True;
            AllowCloudRecording                        = $False;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $True;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $True;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $True;
            AllowParticipantGiveRequestControl         = $True;
            AllowPowerPointSharing                     = $True;
            AllowPrivateMeetingScheduling              = $True;
            AllowPrivateMeetNow                        = $True;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $True;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $True;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            Credential                                 = $Credscredential;
            Description                                = "Do not assign. This policy is similar to global defaults and would be deprecated";
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            Identity                                   = "Tag:RestrictedAnonymousNoRecording";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "Disabled";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Enabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "OneDriveForBusiness";
            ScreenSharingMode                          = "EntireScreen";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
            WhoCanRegister                             = "Everyone";
        }
        TeamsMeetingPolicy 041e0b28-59c6-4358-af2a-2b42a2a5627e
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $True;
            AllowCloudRecording                        = $True;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $True;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $True;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $True;
            AllowParticipantGiveRequestControl         = $True;
            AllowPowerPointSharing                     = $True;
            AllowPrivateMeetingScheduling              = $True;
            AllowPrivateMeetNow                        = $True;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $True;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $True;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            Credential                                 = $Credscredential;
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            Identity                                   = "Tag:Default";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "DisabledUserOverride";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Enabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "OneDriveForBusiness";
            ScreenSharingMode                          = "EntireScreen";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
            WhoCanRegister                             = "Everyone";
        }
        TeamsMeetingPolicy 5ea038d7-0e44-409a-afa5-89c8a3e1a026
        {
            AllowAnonymousUsersToDialOut               = $False;
            AllowAnonymousUsersToStartMeeting          = $False;
            AllowBreakoutRooms                         = $True;
            AllowChannelMeetingScheduling              = $False;
            AllowCloudRecording                        = $False;
            AllowEngagementReport                      = "Enabled";
            AllowExternalParticipantGiveRequestControl = $False;
            AllowIPAudio                               = $True;
            AllowIPVideo                               = $True;
            AllowMeetingReactions                      = $True;
            AllowMeetNow                               = $True;
            AllowNDIStreaming                          = $False;
            AllowOrganizersToOverrideLobbySettings     = $False;
            AllowOutlookAddIn                          = $False;
            AllowParticipantGiveRequestControl         = $True;
            AllowPowerPointSharing                     = $True;
            AllowPrivateMeetingScheduling              = $False;
            AllowPrivateMeetNow                        = $True;
            AllowPSTNUsersToBypassLobby                = $False;
            AllowRecordingStorageOutsideRegion         = $False;
            AllowSharedNotes                           = $True;
            AllowTranscription                         = $False;
            AllowUserToJoinExternalMeeting             = "Disabled";
            AllowWhiteboard                            = $True;
            AutoAdmittedUsers                          = "EveryoneInCompany";
            Credential                                 = $Credscredential;
            DesignatedPresenterRoleMode                = "EveryoneUserOverride";
            EnrollUserOverride                         = "Disabled";
            Ensure                                     = "Present";
            Identity                                   = "Tag:Kiosk";
            IPAudioMode                                = "EnabledOutgoingIncoming";
            IPVideoMode                                = "EnabledOutgoingIncoming";
            LiveCaptionsEnabledType                    = "Disabled";
            MediaBitRateKb                             = 50000;
            MeetingChatEnabledType                     = "Enabled";
            PreferredMeetingProviderForIslandsMode     = "TeamsAndSfb";
            RecordingStorageMode                       = "OneDriveForBusiness";
            ScreenSharingMode                          = "EntireScreen";
            StreamingAttendeeMode                      = "Disabled";
            TeamsCameraFarEndPTZMode                   = "Disabled";
            VideoFiltersMode                           = "AllFilters";
            WhoCanRegister                             = "Everyone";
        }
        TeamsMessagingPolicy 94e76544-753f-4102-9399-d63ac17af5c7
        {
            AllowGiphy                    = $True;
            AllowImmersiveReader          = $True;
            AllowMemes                    = $True;
            AllowOwnerDeleteMessage       = $False;
            AllowPriorityMessages         = $True;
            AllowRemoveUser               = $True;
            AllowStickers                 = $True;
            AllowUrlPreviews              = $True;
            AllowUserChat                 = $True;
            AllowUserDeleteMessage        = $True;
            AllowUserEditMessage          = $True;
            AllowUserTranslation          = $True;
            AudioMessageEnabledType       = "ChatsAndChannels";
            ChannelsInChatListEnabledType = "DisabledUserOverride";
            Credential                    = $Credscredential;
            Ensure                        = "Present";
            GiphyRatingType               = "Moderate";
            Identity                      = "Global";
            ReadReceiptsEnabledType       = "UserPreference";
        }
        TeamsMessagingPolicy 3f253e59-3363-4884-ad7a-6e99af4b3f2c
        {
            AllowGiphy                    = $True;
            AllowImmersiveReader          = $True;
            AllowMemes                    = $True;
            AllowOwnerDeleteMessage       = $False;
            AllowPriorityMessages         = $True;
            AllowRemoveUser               = $True;
            AllowStickers                 = $True;
            AllowUrlPreviews              = $True;
            AllowUserChat                 = $True;
            AllowUserDeleteMessage        = $True;
            AllowUserEditMessage          = $True;
            AllowUserTranslation          = $True;
            AudioMessageEnabledType       = "ChatsAndChannels";
            ChannelsInChatListEnabledType = "DisabledUserOverride";
            Credential                    = $Credscredential;
            Ensure                        = "Present";
            GiphyRatingType               = "Moderate";
            Identity                      = "Default";
            ReadReceiptsEnabledType       = "UserPreference";
        }
        TeamsMessagingPolicy 32a71bb8-faff-43ac-a80c-4053871f7753
        {
            AllowGiphy                    = $False;
            AllowImmersiveReader          = $True;
            AllowMemes                    = $True;
            AllowOwnerDeleteMessage       = $True;
            AllowPriorityMessages         = $True;
            AllowRemoveUser               = $True;
            AllowStickers                 = $True;
            AllowUrlPreviews              = $True;
            AllowUserChat                 = $True;
            AllowUserDeleteMessage        = $True;
            AllowUserEditMessage          = $True;
            AllowUserTranslation          = $True;
            AudioMessageEnabledType       = "ChatsAndChannels";
            ChannelsInChatListEnabledType = "DisabledUserOverride";
            Credential                    = $Credscredential;
            Ensure                        = "Present";
            GiphyRatingType               = "Strict";
            Identity                      = "EduFaculty";
            ReadReceiptsEnabledType       = "UserPreference";
        }
        TeamsMessagingPolicy c2d25fd4-1862-47d4-bf75-f51ec14dffb6
        {
            AllowGiphy                    = $False;
            AllowImmersiveReader          = $True;
            AllowMemes                    = $True;
            AllowOwnerDeleteMessage       = $False;
            AllowPriorityMessages         = $True;
            AllowRemoveUser               = $True;
            AllowStickers                 = $True;
            AllowUrlPreviews              = $True;
            AllowUserChat                 = $True;
            AllowUserDeleteMessage        = $True;
            AllowUserEditMessage          = $True;
            AllowUserTranslation          = $True;
            AudioMessageEnabledType       = "ChatsAndChannels";
            ChannelsInChatListEnabledType = "DisabledUserOverride";
            Credential                    = $Credscredential;
            Ensure                        = "Present";
            GiphyRatingType               = "Strict";
            Identity                      = "EduStudent";
            ReadReceiptsEnabledType       = "UserPreference";
        }
        TeamsTenantDialPlan 1a6101e8-a335-4088-a016-232a0cf32486
        {
            Credential            = $Credscredential;
            Ensure                = "Present";
            Identity              = "Global";
            NormalizationRules    = @();
            OptimizeDeviceDialing = $False;
            SimpleName            = "DefaultTenantDialPlan";
        }
        TeamsUpgradeConfiguration b481a765-e785-4b2d-b1f7-54d721913f34
        {
            Credential           = $Credscredential;
            DownloadTeams        = $True;
            IsSingleInstance     = "Yes";
            SfBMeetingJoinUx     = "NativeLimitedClient";
        }
        TeamsUpgradePolicy 8bee9633-37bf-47a6-9dce-7901c64f9e4d
        {
            Credential             = $Credscredential;
            Identity               = "Global";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy 03800513-7d52-42b2-acd4-89a497fe0c35
        {
            Credential             = $Credscredential;
            Identity               = "UpgradeToTeams";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy 40bf74e9-2b09-4c0a-bb96-5cea85b67e7d
        {
            Credential             = $Credscredential;
            Identity               = "Islands";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy ac0967d3-b6e9-4c80-8fb4-36b532732e49
        {
            Credential             = $Credscredential;
            Identity               = "IslandsWithNotify";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy 81cc1b60-18c7-4103-9dbd-a01416fdb569
        {
            Credential             = $Credscredential;
            Identity               = "SfBOnly";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy 8def9e99-e33a-4144-9d80-c0faf97c5c5a
        {
            Credential             = $Credscredential;
            Identity               = "SfBOnlyWithNotify";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy 1d50285d-dbb5-4a99-b6a7-f9ef66f80a69
        {
            Credential             = $Credscredential;
            Identity               = "SfBWithTeamsCollab";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy 75ba8f69-557a-42bf-b4ce-6255b6d1311a
        {
            Credential             = $Credscredential;
            Identity               = "SfBWithTeamsCollabWithNotify";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy 2fd561aa-80ce-4c64-b353-6e507e480f6f
        {
            Credential             = $Credscredential;
            Identity               = "SfBWithTeamsCollabAndMeetings";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsUpgradePolicy c2417297-bdfe-4897-ac00-a7971d7f7ae1
        {
            Credential             = $Credscredential;
            Identity               = "SfBWithTeamsCollabAndMeetingsWithNotify";
            MigrateMeetingsToTeams = $False;
            Users                  = @();
        }
        TeamsVoiceRoute a5c1f656-89d9-48c1-834e-4d2d4c0d95fa
        {
            Credential            = $Credscredential;
            Ensure                = "Present";
            Identity              = "LocalRoute";
            NumberPattern         = "^(\+1[0-9]{10})$";
            OnlinePstnGatewayList = @();
            OnlinePstnUsages      = @();
            Priority              = 0;
        }
        TeamsVoiceRoutingPolicy 493e2c7a-4602-45df-9186-2d68f4fdd931
        {
            Credential           = $Credscredential;
            Ensure               = "Present";
            Identity             = "Global";
            OnlinePstnUsages     = @();
        }
    }
}
runbook_2022-Feb-10-0802AM -ConfigurationData .\ConfigurationData.psd1 -Credential $Credential
