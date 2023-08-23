-- Base

import System.Directory
import System.Exit (exitSuccess)
import System.IO (hClose, hPutStr, hPutStrLn)
import XMonad
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D (..), WSType (..), moveTo, nextScreen, prevScreen, shiftTo)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotAllDown, rotSlavesDown)
import qualified XMonad.Actions.Search as S
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (killAll, sinkAll)

-- Data
import Data.Char (isSpace, toUpper)
import qualified Data.Map as M
import Data.Maybe (fromJust, isJust)
import Data.Monoid
import Data.Tree

-- Hooks
import XMonad.Hooks.DynamicLog (PP (..), dynamicLogWithPP, shorten, wrap, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isFullscreen)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WindowSwallowing
import XMonad.Hooks.WorkspaceHistory

-- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid (Grid))
import XMonad.Layout.ResizableTile
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (decreaseLimit, increaseLimit, limitWindows)
import XMonad.Layout.MultiToggle (EOT (EOT), mkToggle, single, (??))
import qualified XMonad.Layout.MultiToggle as MT (Toggle (..))
import XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import qualified XMonad.Layout.ToggleLayouts as T (ToggleLayout (Toggle), toggleLayouts)
import XMonad.Layout.WindowArranger (WindowArrangerMsg (..), windowArrange)
import XMonad.Layout.WindowNavigation

-- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP, mkNamedKeymap)
import XMonad.Util.Hacks (javaHack, trayAbovePanelEventHook, trayPaddingEventHook, trayPaddingXmobarEventHook, trayerAboveXmobarEventHook, trayerPaddingXmobarEventHook, windowedFullscreenFixEventHook)
import XMonad.Util.NamedActions
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

-- Color Scheme
import Colors.Nord

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBrowser :: String
myBrowser = "brave"

myEditor :: String
myEditor = myTerminal ++ " -e vim "

myBorderWidth :: Dimension
myBorderWidth = 2

myNormColor :: String
myNormColor = colorBack

myFocusColor :: String
myFocusColor = color15

mySoundPlayer :: String
mySoundPlayer = "ffplay -nodisp -autoexit "

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    spawnOnce (mySoundPlayer ++ startupSound)
    spawn "killall trayer"

    spawnOnce "lxsession"
    spawnOnce "picom"
    spawnOnce "nm-applet"
    spawnOnce "volumeicon"
    spawnOnce "notify-log $HOME/.log/notify.log"
    spawn ("sleep 2 && trayer --edge top --align right --widthtype request --padding 6 --SetDockType true --SetPartialStrut true --expand true --monitor 1 --transparent true --alpha 0 " ++ colorTrayer ++ " --height 22")

    spawnOnce "nitrogen --restore &"
    setWMName "LG3D"

myNavigation :: TwoD a (Maybe a)
myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
  where
    navKeyMap =
        M.fromList
            [ ((0, xK_Escape), cancel)
            , ((0, xK_Return), select)
            , ((0, xK_slash), substringSearch myNavigation)
            , ((0, xK_Left), move (-1, 0) >> myNavigation)
            , ((0, xK_h), move (-1, 0) >> myNavigation)
            , ((0, xK_Right), move (1, 0) >> myNavigation)
            , ((0, xK_l), move (1, 0) >> myNavigation)
            , ((0, xK_Down), move (0, 1) >> myNavigation)
            , ((0, xK_j), move (0, 1) >> myNavigation)
            , ((0, xK_Up), move (0, -1) >> myNavigation)
            , ((0, xK_k), move (0, -1) >> myNavigation)
            , ((0, xK_y), move (-1, -1) >> myNavigation)
            , ((0, xK_i), move (1, -1) >> myNavigation)
            , ((0, xK_n), move (-1, 1) >> myNavigation)
            , ((0, xK_m), move (1, -1) >> myNavigation)
            , ((0, xK_space), setPos (0, 0) >> myNavigation)
            ]
    navDefaultHandler = const myNavigation

myColorizer :: Window -> Bool -> X (String, String)
myColorizer =
    colorRangeFromClassName
        (0x28, 0x2c, 0x34)
        (0x28, 0x2c, 0x34)
        (0xc7, 0x92, 0xea)
        (0xc0, 0xa7, 0x9a)
        (0x28, 0x2c, 0x34)

-- Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts
tall =
    renamed [Replace "tall"] $
        limitWindows 5 $
            smartBorders $
                windowNavigation $
                    addTabs shrinkText myTabTheme $
                        subLayout [] (smartBorders Simplest) $
                            mySpacing 8 $
                                ResizableTall 1 (3 / 100) (1 / 2) []
monocle =
    renamed [Replace "monocle"] $
        smartBorders $
            windowNavigation $
                addTabs shrinkText myTabTheme $
                    subLayout [] (smartBorders Simplest) $
                        Full
floats =
    renamed [Replace "floats"] $
        smartBorders $
            simplestFloat

tabs = renamed [Replace "tabs"]

-- setting colors for tabs layout and tabs sublayout.
myTabTheme =
    def
        { fontName = myFont
        , activeColor = color15
        , inactiveColor = color08
        , activeBorderColor = color15
        , inactiveBorderColor = colorBack
        , activeTextColor = colorBack
        , inactiveTextColor = color16
        }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme =
    def
        { swn_font = "xft:Ubuntu:bold:size=80"
        , swn_fade = 1.0
        , swn_bgcolor = "#1c1f24"
        , swn_color = "#ffffff"
        }

-- The Layout Hook
myLayoutHook =
    avoidStruts $
        mouseResize $
            windowArrange $
                T.toggleLayouts floats $
                    mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
  where
    myDefaultLayout =
        withBorder myBorderWidth tall
            ||| noBorders monocle

myWorkspaces = [" dev ", " www ", " note ", " app ", " file ", " doc ", " chat ", " mus ", " vid ", ""]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1 ..]

clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook =
    composeAll
        [ className =? "confirm" --> doFloat
        , className =? "file_progress" --> doFloat
        , className =? "dialog" --> doFloat
        , className =? "download" --> doFloat
        , className =? "error" --> doFloat
        , className =? "Gimp" --> doFloat
        , className =? "notification" --> doFloat
        , className =? "pinentry-gtk-2" --> doFloat
        , className =? "splash" --> doFloat
        , className =? "toolbar" --> doFloat
        , className =? "Yad" --> doCenterFloat
        , className =? "Brave-browser" --> doShift (myWorkspaces !! 1)
        , className =? "obsidian" --> doShift (myWorkspaces !! 2)
        , className =? "dolphin" --> doShift (myWorkspaces !! 4)
        , className =? "vlc" --> doShift (myWorkspaces !! 8)
        , className =? "mpv" --> doShift (myWorkspaces !! 0)
        , (className =? "firefox" <&&> resource =? "Dialog") --> doFloat -- Float Firefox Dialog
        , isFullscreen --> doFullFloat
        ]

soundDir = "/opt/dtos-sounds/"

startupSound = soundDir ++ "pain-startup.mp3"
shutdownSound = soundDir ++ "naruto-shutdown.mp3"

subtitle' :: String -> ((KeyMask, KeySym), NamedAction)
subtitle' x =
    ( (0, 0)
    , NamedAction $
        map toUpper $
            sep ++ "\n-- " ++ x ++ " --\n" ++ sep
    )
  where
    sep = replicate (6 + length x) '-'

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" $ io $ do
    h <- spawnPipe $ "yad --text-info --fontname=\"SauceCodePro Nerd Font Mono 11\" --fore=#46d9ff back=#282c36 --center --geometry=1200x800 --title \"XMonad keybindings\""
    hPutStr h (unlines $ showKmSimple x)
    hClose h
    return ()

-- My Custom Keybindings
myKeys :: XConfig l0 -> [((KeyMask, KeySym), NamedAction)]
myKeys c =
    let subKeys str ks = subtitle' str : mkNamedKeymap c ks
     in subKeys
            "Xmonad Essentials"
            [ ("M-S-x", addName "Recompile XMonad" $ spawn "xmonad --recompile")
            , ("M-S-r", addName "Restart XMonad" $ spawn "xmonad --restart")
            , ("M-S-q", addName "Quit XMonad" $ sequence_ [spawn (mySoundPlayer ++ shutdownSound), io exitSuccess])
            , ("M-S-c", addName "Kill focused window" $ kill1)
            , ("M-S-a", addName "Kill all windows on WS" $ killAll)
            , ("M-S-b", addName "Toggle bar show/hide" $ sendMessage ToggleStruts)
            , ("M-q", addName "Quit Laptop" $ spawn "shutdown -h now")
            ]
            ^++^ subKeys
                "Switch to workspace"
                [ ("M-1", addName "Switch to workspace 1" $ (windows $ W.greedyView $ myWorkspaces !! 0))
                , ("M-2", addName "Switch to workspace 2" $ (windows $ W.greedyView $ myWorkspaces !! 1))
                , ("M-3", addName "Switch to workspace 3" $ (windows $ W.greedyView $ myWorkspaces !! 2))
                , ("M-4", addName "Switch to workspace 4" $ (windows $ W.greedyView $ myWorkspaces !! 3))
                , ("M-5", addName "Switch to workspace 5" $ (windows $ W.greedyView $ myWorkspaces !! 4))
                , ("M-6", addName "Switch to workspace 6" $ (windows $ W.greedyView $ myWorkspaces !! 5))
                , ("M-7", addName "Switch to workspace 7" $ (windows $ W.greedyView $ myWorkspaces !! 6))
                , ("M-8", addName "Switch to workspace 8" $ (windows $ W.greedyView $ myWorkspaces !! 7))
                , ("M-9", addName "Switch to workspace 9" $ (windows $ W.greedyView $ myWorkspaces !! 8))
                ]
            ^++^ subKeys
                "Send window to workspace"
                [ ("M-S-1", addName "Send to workspace 1" $ (windows $ W.shift $ myWorkspaces !! 0))
                , ("M-S-2", addName "Send to workspace 2" $ (windows $ W.shift $ myWorkspaces !! 1))
                , ("M-S-3", addName "Send to workspace 3" $ (windows $ W.shift $ myWorkspaces !! 2))
                , ("M-S-4", addName "Send to workspace 4" $ (windows $ W.shift $ myWorkspaces !! 3))
                , ("M-S-5", addName "Send to workspace 5" $ (windows $ W.shift $ myWorkspaces !! 4))
                , ("M-S-6", addName "Send to workspace 6" $ (windows $ W.shift $ myWorkspaces !! 5))
                , ("M-S-7", addName "Send to workspace 7" $ (windows $ W.shift $ myWorkspaces !! 6))
                , ("M-S-8", addName "Send to workspace 8" $ (windows $ W.shift $ myWorkspaces !! 7))
                , ("M-S-9", addName "Send to workspace 9" $ (windows $ W.shift $ myWorkspaces !! 8))
                ]
            ^++^ subKeys
                "Window navigation"
                [ ("M-j", addName "Move focus to next window" $ windows W.focusDown)
                , ("M-k", addName "Move focus to prev window" $ windows W.focusUp)
                , ("M-m", addName "Move focus to master window" $ windows W.focusMaster)
                , ("M-S-j", addName "Swap focused window with next window" $ windows W.swapDown)
                , ("M-S-k", addName "Swap focused window with prev window" $ windows W.swapUp)
                , ("M-S-m", addName "Swap focused window with master window" $ windows W.swapMaster)
                ]
            ^++^ subKeys
                "Favorite programs"
                [ ("M-<Return>", addName "Launch terminal" $ spawn (myTerminal))
                , ("M-b", addName "Launch web browser" $ spawn (myBrowser))
                , ("M-e", addName "Launch file manager" $ spawn "dolphin")
                , ("M-g", addName "Launch google" $ spawn "google-chrome-stable")
                , ("M-c", addName "Launch vs code" $ spawn "code")
                , ("M-o", addName "Launch obsidian" $ spawn "obsidian")
                , ("M-s", addName "Launch rofi" $ spawn "/home/gobi/.config/rofi/scripts/launcher_t4")
                , ("M-0", addName "Launch rofi" $ spawn "brightnessctl set +10%")
                , ("M--", addName "Launch rofi" $ spawn "brightnessctl set 10%-")
                , ("M-;", addName "Launch rofi" $ spawn "rofi -show emoji")
                , ("M-'", addName "Launch rofi" $ spawn "rofi -show calc -no-show-match -no-sort")
                ]
            ^++^ subKeys
                "Switch layouts"
                [ ("M-<Tab>", addName "Switch to next layout" $ sendMessage NextLayout)
                , ("M-<Space>", addName "Toggle noborders/full" $ sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts)
                ]
            ^++^ subKeys
                "Window resizing"
                [ ("M-h", addName "Shrink window" $ sendMessage Shrink)
                , ("M-l", addName "Expand window" $ sendMessage Expand)
                , ("M-d", addName "Shrink window vertically" $ sendMessage MirrorShrink)
                , ("M-u", addName "Expand window vertically" $ sendMessage MirrorExpand)
                ]
            ^++^ subKeys
                "Floating windows"
                [ ("M-f", addName "Toggle float layout" $ sendMessage (T.Toggle "floats"))
                , ("M-t", addName "Sink a floating window" $ withFocused $ windows . W.sink)
                , ("M-S-t", addName "Sink all floated windows" $ sinkAll)
                ]
            ^++^ subKeys
                "Window spacing (gaps)"
                [ ("M-M1-j", addName "Decrease window spacing" $ decWindowSpacing 4)
                , ("M-M1-k", addName "Increase window spacing" $ incWindowSpacing 4)
                , ("M-M1-h", addName "Decrease screen spacing" $ decScreenSpacing 4)
                , ("M-M1-l", addName "Increase screen spacing" $ incScreenSpacing 4)
                ]
            ^++^ subKeys
                "Sublayouts"
                [ ("M-C-h", addName "pullGroup L" $ sendMessage $ pullGroup L)
                , ("M-C-l", addName "pullGroup R" $ sendMessage $ pullGroup R)
                , ("M-C-j", addName "pullGroup D" $ sendMessage $ pullGroup D)
                , ("M-C-k", addName "pullGroup U" $ sendMessage $ pullGroup U)
                , ("M-C-m", addName "MergeAll" $ withFocused (sendMessage . MergeAll))
                , ("M-C-u", addName "UnMerge" $ withFocused (sendMessage . UnMerge))
                , ("M-C-/", addName "UnMergeAll" $ withFocused (sendMessage . UnMergeAll))
                , ("M-C-n", addName "Switch focus next tab" $ onGroup W.focusUp')
                , ("M-C-p", addName "Switch focus prev tab" $ onGroup W.focusDown')
                ]
            ^++^ subKeys
                "Multimedia keys"
                [ ("<XF86AudioMute>", addName "Toggle audio mute" $ spawn "amixer set Master toggle")
                , ("<XF86AudioLowerVolume>", addName "Lower vol" $ spawn "amixer set Master 5%- unmute")
                , ("<XF86AudioRaiseVolume>", addName "Raise vol" $ spawn "amixer set Master 5%+ unmute")
                , ("<XF86Eject>", addName "Eject /dev/cdrom" $ spawn "eject /dev/cdrom")
                ]

-- Xmobar Setup
main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe ("xmobar -x 0 $HOME/.config/xmobar/" ++ colorScheme ++ "-xmobarrc")
    xmonad $
        addDescrKeys' ((mod4Mask, xK_F1), showKeybindings) myKeys $
            ewmh $
                docks $
                    def
                        { manageHook = myManageHook <+> manageDocks
                        , handleEventHook = windowedFullscreenFixEventHook <> swallowEventHook (className =? "Alacritty" <||> className =? "st-256color" <||> className =? "XTerm") (return True) <> trayerPaddingXmobarEventHook
                        , modMask = myModMask
                        , terminal = myTerminal
                        , startupHook = myStartupHook
                        , layoutHook = showWName' myShowWNameTheme $ myLayoutHook
                        , workspaces = myWorkspaces
                        , borderWidth = myBorderWidth
                        , normalBorderColor = myNormColor
                        , focusedBorderColor = myFocusColor
                        , logHook =
                            dynamicLogWithPP $
                                filterOutWsPP [scratchpadWorkspaceTag] $
                                    xmobarPP
                                        { ppOutput = \x -> hPutStrLn xmproc0 x
                                        , ppCurrent =
                                            xmobarColor color06 ""
                                                . wrap
                                                    ("<box type=Bottom width=2 mb=2 color=" ++ color06 ++ ">")
                                                    "</box>"
                                        , -- Visible but not current workspace
                                          ppVisible = xmobarColor color06 "" . clickable
                                        , -- Hidden workspace
                                          ppHidden =
                                            xmobarColor color05 ""
                                                . wrap
                                                    ("<box type=Top width=2 mt=2 color=" ++ color05 ++ ">")
                                                    "</box>"
                                                . clickable
                                        , -- Hidden workspaces (no windows)
                                          ppHiddenNoWindows = xmobarColor color05 "" . clickable
                                        , -- Title of active window
                                          ppTitle = xmobarColor color16 "" . shorten 60
                                        , -- Separator character
                                          ppSep = "<fc=" ++ color09 ++ "> <fn=1>|</fn> </fc>"
                                        , -- Urgent workspace
                                          ppUrgent = xmobarColor color02 "" . wrap "!" "!"
                                        , -- Adding # of windows on current workspace to the bar
                                          ppExtras = [windowCount]
                                        , -- order of things in xmobar
                                          ppOrder = \(ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
                                        }
                        }
