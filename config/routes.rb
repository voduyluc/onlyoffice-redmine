#
# (c) Copyright Ascensio System SIA 2021
# http://www.onlyoffice.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

get 'onlyoffice/download/:id/:filename', :to => 'onlyoffice#download', :id => /\d+/, :filename => /.*/
get 'onlyoffice/download/:id', :to => 'onlyoffice#download', :id => /\d+/
get 'onlyoffice/editor/:id', :to => 'onlyoffice#editor', :id => /\d+/
get 'onlyoffice/editor/:id/:action_data', :to => 'onlyoffice#editor', :id => /\d+/, :action_data => /.*/

post 'onlyoffice/callback/:id/:rss', :to => 'onlyoffice#callback', :id => /\d+/, :rss => /.*/