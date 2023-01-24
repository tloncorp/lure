/-  reel
/+  default-agent, verb, dbug, server
|%
+$  card  card:agent:gall
+$  versioned-state
  $%  state-0
  ==
::
+$  state-0
  $:  %0
      todd=(map [inviter=ship token=cord] description=cord)
  ==
--
::
|%
++  landing-page
  |=  description=cord
  ^-  manx
  ;html
    ;head
      ;title:"Lure"
    ==
    ;body
      ;p: description: {<(trip description)>}
      Enter your @p:
      ;form(method "post")
        ;input(type "text", name "ship", id "ship", placeholder "~sampel");
        ;button(type "submit"):"Request invite"
      ==
      ;script: ship = document.cookie.split("; ").find((row) => row.startsWith("ship="))?.split("=")[1]; document.getElementById("ship").value=(ship || "~sampel-palnet")
    ==
  ==
::
++  sent-page
  |=  invitee=ship
  ^-  manx
  ;html
    ;head
      ;title:"Lure"
    ==
    ;body
      Your invite has been sent!  Go to your ship to accept it.
      ;script: document.cookie="ship={(trip (scot %p invitee))}"
    ==
  ==
--
::
=|  state-0
=*  state  -
::
%-  agent:dbug
%+  verb  |
|_  =bowl:gall
+*  this       .
    def        ~(. (default-agent this %|) bowl)
::
++  on-init
  ^-  (quip card _this)
  [[%pass /eyre/connect %arvo %e %connect [~ /lure] dap.bowl]~ this]
::
++  on-save  !>(state)
++  on-load
  |=  old-state=vase
  ^-  (quip card _this)
  =/  old  !<(versioned-state old-state)
  ?>  ?=(%0 -.old)
  `this(state old)
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %handle-http-request
    =+  !<([id=@ta inbound-request:eyre] vase)
    |^
    :_  this
    =/  line=request-line:server  (parse-request-line:server url.request)
    =/  inviter
      ?:  ?=([[~ [%lure @ @ ~]] ~] line)
        (slav %p i.t.site.line)
      ?:  ?=([[~ [@ @ ~]] ~] line)
        (slav %p i.site.line)
      !!
    =/  token
      ?:  ?=([[~ [%lure @ @ ~]] ~] line)
        i.t.t.site.line
      ?:  ?=([[~ [@ @ ~]] ~] line)
        i.t.site.line
      !!
    ?+    method.request  (give not-found:gen:server)
        %'GET'
      =/  description  (fall (~(get by todd) [inviter token]) '')
      (give (manx-response:gen:server (landing-page description)))
        %'POST'
      ?~  body.request
        (give not-found:gen:server)
      ?.  =('ship=%7E' (end [3 8] q.u.body.request))
        (give not-found:gen:server)
      =/  invitee  (slav %p (cat 3 '~' (rsh [3 8] q.u.body.request)))
      :-  :*  %pass  /bite  %agent  [inviter %reel]
              %poke  %reel-bite  !>([%bite-0 token invitee])
          ==
      (give (manx-response:gen:server (sent-page invitee)))
    ==
    ::
    ++  give
      |=  =simple-payload:http
      (give-simple-payload:app:server id simple-payload)
    --
      %describe
    =+  !<([token=cord description=cord] vase)
    `this(todd (~(put by todd) [src.bowl token] description))
  ::g
      %undescribe
    =+  !<(token=cord vase)
    `this(todd (~(del by todd) [src.bowl token]))
      %bind-slash
    :_  this
    ~[[%pass /eyre/connect %arvo %e %connect [~ /] dap.bowl]]
      %unbind-slash
    :_  this
    ~[[%pass /eyre/connect %arvo %e %connect [~ /] %docket]]
  ==
::
++  on-agent  on-agent:def
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?>  =(our.bowl src.bowl)
  ?+  path  (on-watch:def path)
    [%http-response *]  `this
  ==
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  ?+    sign-arvo  (on-arvo:def wire sign-arvo)
      [%eyre %bound *]
    ~?  !accepted.sign-arvo
      [dap.bowl 'eyre bind rejected!' binding.sign-arvo]
    [~ this]
  ==
::
++  on-fail   on-fail:def
--
