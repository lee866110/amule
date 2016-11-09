#
# This file is part of the aMule Project.
#
# Copyright (c) 2011 Werner Mahr (Vollstrecker) <amule@vollstreckernet.de>
#
# Any parts of this program contributed by third-party developers are copyrighted
# by their respective authors.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301, USA
#
# This file contains the options for en- or disabling parts of aMule, and
# sets the needed variables for them to compile
#

OPTION (BUILD_ALC "compile aLinkCreator GUI version")
OPTION (BUILD_ALCC "compile aLinkCreator for console")
OPTION (BUILD_AMULECMD "compile aMule command line client")
OPTION (BUILD_EVERYTHING "compile all parts of aMule")
OPTION (BUILD_CAS "compile C aMule Statistics")
OPTION (BUILD_DAEMON "compile aMule daemon version")
OPTION (BUILD_ED2K "compile aMule ed2k links handler" ON)
OPTION (BUILD_FILEVIEW "compile aMule file viewer for console (EXPERIMENTAL)")
OPTION (BUILD_MONOLITHIC "enable building of the monolithic aMule app" ON)
OPTION (BUILD_PLASMAMULE "compile aMule plasma applet and engine")
OPTION (BUILD_REMOTEGUI "compile aMule remote GUI")
OPTION (BUILD_WEBSERVER "compile aMule WebServer")
OPTION (BUILD_WXCAS "compile aMule GUI Statistics")
OPTION (ENABLE_DEBUG "enable additional debugging output" ON)

IF (PREFIX)
	SET (CMAKE_INSTALL_PREFIX "${PREFIX}")
ENDIF (PREFIX)

SET (EXEC_PREFIX "${CMAKE_INSTALL_PREFIX}")
SET (LIBDIR "${EXEC_PREFIX}/lib")
SET (DATADIR "${CMAKE_INSTALL_PREFIX}/share/${DATAROOTDIR}")
SET (MANDIR "${DATADIR}/man")
SET (PKGDATADIR "${DATADIR}/${PACKAGE}")
SET (DOCDIR "${DATADIR}/${PACKAGE}/doc")

IF (BUILD_EVERYTHING)
	SET (BUILD_ALC ON)
	SET (BUILD_ALCC ON)
	SET (BUILD_AMULECMD ON)
	SET (BUILD_CAS ON)
	SET (BUILD_DAEMON ON)
	SET (BUILD_FILEVIEW ON)
	SET (BUILD_PLASMAMULE ON)
	SET (BUILD_REMOTEGUI ON)
	SET (BUILD_WEBSERVER ON)
	SET (BUILD_WXCAS ON)
ENDIF (BUILD_EVERYTHING)

IF (BUILD_AMULECMD)
	SET (NEED_LIB_EC TRUE)
	SET (NEED_LIB_MULECOMMON TRUE)
	SET (NEED_LIB_MULESOCKET TRUE)
	SET (wx_NEED_NET TRUE)
	SET (NEED_ZLIB TRUE)
ENDIF (BUILD_AMULECMD)

IF (BUILD_CAS)
	SET (BUILD_UTIL TRUE)
ENDIF (BUILD_CAS)

IF (BUILD_ALCC)
	SET (BUILD_UTIL TRUE)
	SET (wx_NEED_BASE TRUE)
ENDIF (BUILD_ALCC)

IF (BUILD_ALC)
	SET (BUILD_UTIL TRUE)
	SET (wx_NEED_GUI TRUE)
ENDIF (BUILD_ALC)

IF (BUILD_DAEMON)
	SET (NEED_LIB_EC TRUE)
	SET (NEED_LIB_MULEAPPCOMMON TRUE)
	SET (NEED_LIB_MULECOMMON TRUE)
	SET (NEED_LIB_MULESOCKET TRUE)
	SET (NEED_ZLIB TRUE)
	SET (wx_NEED_NET TRUE)
ENDIF (BUILD_DAEMON)

IF (BUILD_ED2K)
	SET (wx_NEED_BASE TRUE)
ENDIF (BUILD_ED2K)

IF (BUILD_FILEVIEW)
	SET (BUILD_UTIL TRUE)
	SET (NEED_LIB_CRYPTO TRUE)
	SET (NEED_LIB_MULECOMMON TRUE)
	SET (wx_NEED_NET TRUE)
ENDIF (BUILD_FILEVIEW)

IF (BUILD_MONOLITHIC)
	SET (NEED_LIB_EC TRUE)
	SET (NEED_LIB_MULEAPPGUI TRUE)
	SET (NEED_LIB_MULEAPPCOMMON TRUE)
	SET (NEED_LIB_MULECOMMON TRUE)
	SET (NEED_LIB_MULESOCKET TRUE)
	SET (NEED_ZLIB TRUE)
	SET (wx_NEED_ADV TRUE)
ENDIF (BUILD_MONOLITHIC)

IF (BUILD_MONOLITHIC OR BUILD_REMOTEGUI)
	SET (INSTALL_SKINS TRUE)
ENDIF (BUILD_MONOLITHIC OR BUILD_REMOTEGUI)

IF (BUILD_PLASMAMULE)
	SET (BUILD_UTIL TRUE)
ENDIF (BUILD_PLASMAMULE)

IF (BUILD_REMOTEGUI)
	SET (NEED_GLIB_CHECK TRUE)
	SET (NEED_LIB_EC TRUE)
	SET (NEED_LIB_MULEAPPCOMMON TRUE)
	SET (NEED_LIB_MULEAPPGUI TRUE)
	SET (NEED_LIB_MULECOMMON TRUE)
	SET (NEED_LIB_MULESOCKET TRUE)
	SET (NEED_ZLIB TRUE)
	SET (wx_NEED_ADV TRUE)
	SET (wx_NEED_NET TRUE)
ENDIF (BUILD_REMOTEGUI)

IF (BUILD_WEBSERVER)
	SET (NEED_LIB_EC TRUE)
	SET (NEED_LIB_MULECOMMON TRUE)
	SET (NEED_LIB_MULESOCKET TRUE)
	SET (NEED_ZLIB TRUE)
	SET (WEBSERVERDIR "${PKGDATADIR}/webserver/")
	SET (wx_NEED_NET TRUE)
ENDIF (BUILD_WEBSERVER)

IF (BUILD_WXCAS)
	SET (BUILD_UTIL TRUE)
	SET (wx_NEED_GUI TRUE)
	SET (wx_NEED_NET TRUE)
ENDIF (BUILD_WXCAS)

IF (ENABLE_DEBUG)
	ADD_DEFINITIONS ("-D__DEBUG__")
	SET (CMAKE_BUILD_TYPE DEBUG)
ELSE (ENABLE_DEBUG)
	SET (CMAKE_BUILD_TYPE RELEASE)	
ENDIF (ENABLE_DEBUG)

IF (NEED_LIB_EC)
	SET (NEED_LIB_CRYPTO TRUE)
ENDIF (NEED_LIB_EC)

IF (NEED_LIB_MULECOMMON OR NEED_LIB_EC)
	SET (NEED_LIB TRUE)
	SET (wx_NEED_BASE TRUE)
ENDIF (NEED_LIB_MULECOMMON OR NEED_LIB_EC)

IF (NEED_LIB_MULECOMMON)
	SET (NEED_GLIB_CHECK TRUE)
ENDIF (NEED_LIB_MULECOMMON)

IF (NEED_LIB_MULEAPPCOMMON)
	OPTION (ENABLE_IP2COUNTRY "compile with GeoIP IP2Country library")
	OPTION (ENABLE_MMAP "enable using mapped memory if supported")
	OPTION (ENABLE_NLS "enable national language support" ON)
	SET (NEED_LIB_MULEAPPCORE TRUE)
	SET (wx_NEED_BASE TRUE)
ENDIF (NEED_LIB_MULEAPPCOMMON)

IF (NEED_LIB_MULEAPPGUI)
	SET (wx_NEED_GUI TRUE)
ENDIF (NEED_LIB_MULEAPPGUI)

IF (NEED_LIB_MULESOCKET)
	SET (wx_NEED_NET TRUE)
ENDIF (NEED_LIB_MULESOCKET)

IF (wx_NEED_ADV OR wx_NEED_BASE OR wx_NEED_GUI OR wx_NEED_NET)
	SET (wx_NEEDED TRUE)
ENDIF (wx_NEED_ADV OR wx_NEED_BASE OR wx_NEED_GUI OR wx_NEED_NET)

IF (NEED_LIB_MULEAPPCOMMON OR BUILD_WEBSERVER)
	OPTION (ENABLE_UPNP "enable UPnP support in aMule" ON)
ENDIF (NEED_LIB_MULEAPPCOMMON OR BUILD_WEBSERVER)
