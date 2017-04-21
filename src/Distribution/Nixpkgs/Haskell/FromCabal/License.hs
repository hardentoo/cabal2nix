module Distribution.Nixpkgs.Haskell.FromCabal.License ( fromCabalLicense ) where

import Distribution.Nixpkgs.License
import Distribution.License ( License(..), knownLicenses )
import Distribution.Text (display)
import Data.List (intercalate)
import Data.Version

-- TODO: Programatically strip trailing zeros from license version numbers.

fromCabalLicense :: Distribution.License.License -> Distribution.Nixpkgs.License.License
fromCabalLicense (GPL Nothing)                          = Unknown (Just "GPL")
fromCabalLicense (GPL (Just (Version [2] [])))          = Known "stdenv.lib.licenses.gpl2"
fromCabalLicense (GPL (Just (Version [3] [])))          = Known "stdenv.lib.licenses.gpl3"
fromCabalLicense (GPL (Just (Version [3,0] [])))        = Known "stdenv.lib.licenses.gpl3"
fromCabalLicense (LGPL Nothing)                         = Unknown (Just "LGPL")
fromCabalLicense (LGPL (Just (Version [2,1] [])))       = Known "stdenv.lib.licenses.lgpl21"
fromCabalLicense (LGPL (Just (Version [2] [])))         = Known "stdenv.lib.licenses.lgpl2"
fromCabalLicense (LGPL (Just (Version [3] [])))         = Known "stdenv.lib.licenses.lgpl3"
fromCabalLicense (LGPL (Just (Version [3,0] [])))       = Known "stdenv.lib.licenses.lgpl3"
fromCabalLicense (AGPL Nothing)                         = Unknown (Just "AGPL")
fromCabalLicense (AGPL (Just (Version [3] [])))         = Known "stdenv.lib.licenses.agpl3"
fromCabalLicense (AGPL (Just (Version [3,0] [])))       = Known "stdenv.lib.licenses.agpl3"
fromCabalLicense (MPL (Version [2,0] []))               = Known "stdenv.lib.licenses.mpl20"
fromCabalLicense BSD2                                   = Known "stdenv.lib.licenses.bsd2"
fromCabalLicense BSD3                                   = Known "stdenv.lib.licenses.bsd3"
fromCabalLicense BSD4                                   = Known "stdenv.lib.licenses.bsdOriginal"
fromCabalLicense MIT                                    = Known "stdenv.lib.licenses.mit"
fromCabalLicense PublicDomain                           = Known "stdenv.lib.licenses.publicDomain"
fromCabalLicense UnspecifiedLicense                     = Known "stdenv.lib.licenses.unfree"
fromCabalLicense AllRightsReserved                      = Known "stdenv.lib.licenses.unfree"
fromCabalLicense (Apache Nothing)                       = Known "stdenv.lib.licenses.asl20"
fromCabalLicense (Apache (Just (Version [2,0] [])))     = Known "stdenv.lib.licenses.asl20"
fromCabalLicense ISC                                    = Known "stdenv.lib.licenses.isc"
fromCabalLicense OtherLicense                           = Unknown Nothing
fromCabalLicense l                                      = error $ "Distribution.Nixpkgs.Haskell.FromCabal.License.fromCabalLicense: unknown license"
                                                            ++ show l ++"\nChoose one of: " ++ intercalate ", " (map display knownLicenses)
