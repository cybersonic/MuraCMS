 <!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
<cfset request.layout=false>
<cfparam name="rc.keywords" default="">
<cfparam name="rc.isNew" default="1">
<cfset counter=0 />
<cfoutput>
<div class="form-inline input-append">
	<input id="parentSearch" name="parentSearch" value="#HTMLEditFormat(rc.keywords)#" type="text" class="text" maxlength="50" placeholder="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.searchforcontent')#" />
	<button type="button" class="btn" onclick="siteManager.loadRelatedContent('#rc.siteid#',document.getElementById('parentSearch').value,0);return false;"><i class="icon-search"></i></button>
</div>
</cfoutput>

<cfif not rc.isNew>
<cfset rc.rsList=application.contentManager.getPrivateSearch(rc.siteid,rc.keywords)/>
 <table class="table table-striped table-condensed table-bordered mura-table-grid">
    <tr> 
      <th class="var-width"><cfoutput><a href="##" rel="tooltip" title="#HTMLEditFormat(application.rbFactory.getKeyValue(session.rb,'tooltip.addRelatedContent'))#">#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.fields.addrelatedcontent')# <i class="icon-question-sign"></i></a></cfoutput></th>
	  <th class="actions">&nbsp;</th>
    </tr><cfif rc.rslist.recordcount>
     <cfoutput query="rc.rslist" startrow="1" maxrows="100">	
		<cfset crumbdata=application.contentManager.getCrumbList(rc.rslist.contentid, rc.siteid)/>
        <cfif arrayLen(crumbdata) and structKeyExists(crumbdata[1],"parentArray") and not listFind(arraytolist(crumbdata[1].parentArray),rc.contentid)>
		<cfset counter=counter+1/>
		<tr <cfif not(counter mod 2)>class="alt"</cfif>>  
          <td class="var-width">#$.dspZoomNoLinks(crumbdata)#</td>
		  <td class="actions"><ul><li class="add"><a title="#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.add')#" href="javascript:;" onClick="siteManager.addRelatedContent('#rc.rslist.contentid#','#application.rbFactory.getKeyValue(session.rb,'sitemanager.content.type.#rc.rslist.type#')#','#JSStringFormat($.dspZoomText(crumbdata,"&raquo;"))#'); return false;"><i class="icon-plus-sign"></i></a></li></ul>
		  </td>
		</tr>
	 	</cfif>
       </cfoutput>
	 	<cfelse>
		<tr class="alt"><cfoutput>  
		  <td class="noResults" colspan="2">#application.rbFactory.getKeyValue(session.rb,'sitemanager.noresults')#</td>
		</tr></cfoutput>
		</cfif>
  </table>
</td></tr></table>
</cfif>

