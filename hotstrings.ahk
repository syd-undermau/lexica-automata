#Requires AutoHotkey v2.0

;------------------------------------------------------------------------------
; Win+H to enter misspelling correction.  It will be added to this script.
;------------------------------------------------------------------------------

DefineHotstring(Key, Value, Description := "") {
    try {
        StrVal := String(Value)
    } catch {
        StrVal := "(closure)"
    }
    ; DebugStack.Info("Defining new hotstring: [" . key . "] --> [" . StrVal . "]`t" . Description, 1)

    Hotstring(Key, Value, "On")
}

EscapeKeyString(Str) {
    Str := StrReplace(Str, "``", "````")  ; Do this replacement first to avoid interfering with the others below.
    Str := StrReplace(Str, "`r`n", "``n")
    Str := StrReplace(Str, "`n", "``n")
    Str := StrReplace(Str, "`t", "``t")
    Str := StrReplace(Str, "`;", "```;")

    return Str
}

UnescapeKeyString(Str) {
    Str := StrReplace(Str, "```;", "`;")
    Str := StrReplace(Str, "``t", "`t")
    Str := StrReplace(Str, "``n", "`n")
    Str := StrReplace(Str, "``r``n", "`n")
    Str := StrReplace(Str, "````", "``")  ; Do this replacement last to avoid interfering with the others above.

    return Str
}

#h::
!+h::
AddHotstring(*) {
    PromptTitle := "New Hotstring"
    ReplaceStr := InputBox("Word to replace/expand", PromptTitle, , "btw")

    if ReplaceStr.Result != "OK"
        return

    ShowInputBox(":T:" . EscapeKeyString(ReplaceStr.Value) . "`::")
}

ShowInputBox(DefaultValue)
{
    ; This will move the input box's caret to a more friendly position:
    ; We mark this as critical so that the timer doesn't immediately go off
    Critical "On"
    SetTimer MoveCaret, -20
    ; Show the input box, providing the default hotstring:
    IB := InputBox("
    (
    Type your abbreviation at the indicated insertion point. You can also edit the replacement text if you wish.

    Example entry: :T:btw::by the way
    )", "New Hotstring", , DefaultValue)
    Critical "Off"
    if IB.Result = "Cancel"  ; The user pressed Cancel.
        return

    if RegExMatch(IB.Value, "(?P<Label>:.*?:(?P<Abbreviation>.*?))::(?P<Replacement>.*)", &Entered)
    {
        if !Entered.Abbreviation
            MsgText := "You didn't provide an abbreviation"
        else if !Entered.Replacement
            MsgText := "You didn't provide a replacement"
        else
        {
            DefineHotstring UnescapeKeyString(Entered.Label), Entered.Replacement  ; Enable the hotstring now.
            FileAppend "`n" IB.Value, A_ScriptDir . "\\hotstrings.ahk"  ; Save the hotstring for later use.
        }
    }
    else
        MsgText := "The hotstring appears to be improperly formatted"

    if IsSet(MsgText)
    {
        Result := MsgBox(MsgText ". Would you like to try again?", , 4)
        if Result = "Yes"
            ShowInputBox(DefaultValue)
    }

    MoveCaret()
    {
        if (WinWait("New Hotstring", , 1)) {
            ; Otherwise, move the input box's insertion point to where the user will type the abbreviation.
            ; Send "{Home}{Right 3}"
            Send "{End}"
        }
    }
}

#Include "./comcourts.ahk"

::I'll::I will
::you'll::you will
::she'll::she will
::he'll::he will
::it'll::it will
::we'll::we will
::they'll::they will

; ::I'd::
; ::you'd::
; ::she'd::
; ::he'd::
; ::it'd::
; ::they'd::
; ::we'd::
; ::who'd::
; ::there'd::

::who've::who have
::who're::who are
::could've::could have
::would've::would have
::might've::might have
::should've::should have
::yh::your Honour
::irt``::in relation to
::tbh::to be honest
::wrt::with regards to
::Wed``::Wednesday
::asap::as soon as possible
::miptc::may it please the court
::pty``::proprietary
::ltd``::limited
::resp``::respondent
::appl``::applicant
:C:ABR``::Australian Business Register
::atm::at the moment
::interloc::interlocutory
::interlocinj::interlocutory injunction
::interlocapp::interlocutory application
::irt::in relation to
::dyt::do you think
::wrt::with regards to
::cyt::can you tell
::cit``::can I take

::ws::was
::mhm::mmm
::dont'::don't
::wdym::what do you mean
::dyr::do you remember
::idk::I don't know
::dyk::do you know
::etc::etcetera
::gonna::going to
::migth::might
::circumstnaces::circumstances
::btw::by the way
::jtbc::just to be clear
::wanna::want to
::ofc::of course
::atm::at the moment
::brd::beyond reasonable doubt
::bop::balance of probabilities
::alr::all right
::udnerstand::understand
::tmtt::take me to that
::tytt::take you to that
::ty::thank you
::abotu::about
::teh::the
::dya::do you agree
::dyawt::do you agree with that
::soaf::statement of agreed facts
::safa::statement of agreed facts and submissions
::you'dw::you would
::youwd::you would
::thath::that has
::amyc::and my client
::cmh::case management hearing
::ateotd::at the end of the day
::ntcg::native title claim group
::secfc::security for costs
::soc::statement of claim
::iro::in respect of
::ttc::to the court
::ims::in my submission
::wr::with respect
::imo::in my opinion
::that'dw::that would
::I'dw::I would
::she'dw::she would
::he'dw::he would

#Include "./chief_officers_title.ahk"

::hr``::human resources
:C1:IT``::Information Technology


; Tmp hotstrings

::lit::litigation
::bc::because
::juris::jurisdiction
::Lu``::Lundbeck
::exot::extension of term
::enant``::enantiomer
:T:om``::omission
:T:est``::estoppel
:T:what``::whatever
:T:npr::not pressed
:T:wiwg::which I will go
:T:wiwgth::which I will go through
:T:wiwgt::which I will go to
:T:wtgt::want to go to
:T:ayhhs::as your Honour has seen
:T:corr::correspondence
:T:ws::written submissions
:T:yhws::your Honour will see
:T:pharma::pharmaceutical
:T:exot::extension of term
:T:boa::bundle of authorities
:T:jboa::joint bundle of authorities
:T:ik::I know
:T:subp::subparagraph
:T:tr::that's right
:T:sig::significant
:T:iot::in order to
:T:pov::point of view
:T:remmeber::remember
:T:I've``::I have
:T:wya::would you accept
:T:prob!::probably not
:T:prot``::protestations
:T:coop::cooperation
:T:aff::affidavit
:T:admin``::administration
:T:sub``::submission
:T:subs``::submissions
:T:resju::res judicata
:T:iiciy::if I can invite you
:T:wbox::witness box
:T:decl::declaration
:T:tac::true and correct
:T:dyrec::do you recall
:T:itr::is that right
:T:vol``::volume
:T:dyw::do you want
:T:dywm::do you want me
:T:dywmt::do you want me to
:T:wyag::would you agree
:T:dys::do you see
:T:dyst::do you see that
:T:ext::extension
:T:gp``::general practitioner
:T:misdec::misleading and deceptive
:T:unconcon::unconscionable conduct
:T:circ``::circumstances
:T:xcl::cross-claim
:T:noxcl::notice of cross-claim
:T:soxcl::statement of cross-claim
:T:asoxcl::amended statement of cross-claim
:T:expop::expert opinion
:T:expw::expert witness
:T:const``::constitute
:T:groa::ground of appeal
:T:misodec::misleading or deceptive
:CT:LA``::Limitation Act
:CT:CLR``::Commonwealth Law Reports
:T:ig::I guess
:CT:ICL``::Independent Children's Lawyer
:T:sfc::security for cost
:T:sfca::security for cost application
:T:mpp::matters of practice and procedure
:T:applta::application of leave to appeal
:T:pop``::point of principle
:CT:UN``::United Nations
:T:trpr::travaux pr�paratoires
:T:consoff::consular official
:T:consoffs::consular officials
:T:iregt::in regard to
:T:iregst::in regards to
:T:cyhm::can you hear me?
:CT:ACCC``::Australian Competition and Consumer Commission
:T:fw``::forward
:T:fwd``::forwarded
:T:aoj::administration of justice
:T:mc::my client
:T:iiptc::if it pleases the court
:T:gmyh::good morning, your Honour
:T:judr::Judicial Registrar
:T:np::no problem
:T:iows::in our written submissions
:T:ciityh::can I indicate to your Honour
:T:syh::so your Honour
:T:trmi::trademark infringement
:T:trmic::trademark infringement claim
:T:trmics::trademark infringement claims
:T:iowsia::in our written submissions in answer
:T:frmo::from
:T:trmu::trademark use
:T:incorp::incorporation

:T:wyawt::would you agree with that
:T:dyu::do you understand
:T:dyut::do you understand that
:T:dyuttb::do you understand that to be
:T:dyhacot::do you have a copy of that
:T:dyh::do you have
:T:rn::right now
:C1T:fwa``::Fair Work Act
:T:iwpity``::I will put it to you
:T:ipity``::I put it to you
:T::tm:::trademark
:T:rtrm::registered trademark
:T:itc::is that correct
:C1T:FCFCOA``::Federal Circuit and Family Court of Australia
:T:b4::before
:T:idu::I don't understand
:T:jurisl::jurisdictional
:T:juriserr::jurisdictional error
:T:wibc::would it be correct
:T:wibcts::would it be correct to say
:T:avo``::apprehended violence order
:T:cisty::can I suggest to you
:C1T:nswpf::New South Wales Police Force
:T:dyacc::do you accept
:T:dysfn::dysfunctional
:T:lmk::let me know
:T:dv``::domestic violence
:T:<a::less than a
:T:cayp::can you please
:C1T:CA``::Canada
:C1T:USA``::United States of America
:T:wyat::would you accept that
:T:predom::predominantly
:T:otw::on the way
:T:forendec::forensic decision
:T:info``::information
:T:apportm::apportionment
:T:apportt::apportionate
:T:apportb::apportionable
:T:procfair::procedural fairness
:T:prelim::preliminary
:T:consc``::conscientiously
:T:lenf::law enforcement
:T:cmi::case management issues
:T:tysm::thank you so much
:T:tyr::thank you, Registrar
:T:t&c::terms and conditions
:T:xapp::cross-appeal
:T:secint::security interest
:T:regd::registration date
:T:origapp::originating application
:T:pmsi``::purchase money security interest
:T:intp::interested party
:T:fdo::financial disclosure obligation
:T:instsol::instructing solicitor
:T:suppord::suppression order
:T:woyh::would your Honour
:T:wiyh::will your Honour
:T:cyh::can your Honour
:T:tyh::thank, your Honour
:T:there'll::there will
:?:'ll::{space}will
:T:dyrect::do you recall that
:T:falsdec::false declaration
:T:crimoff::criminal offence
:T:aacps::aids, abets, counsels or procures
:T:aacpg::aiding, abetting, counselling or procuring
:T:aacp::aid, abet, counsel or procure
:T:ftr::for the record
:T:mfi``::mark for identification
:T:mfiftt``::mark for identification for the transcript
:T:defacto::de facto
:T:isty::I suggest to you
:T:iwsty::I would suggest to you
:T:ythit::Yes.  That is true
:T:doc``::document
:T:tblfh::to be listed for hearing
:T:entapp::enterprise agreement
:T:entapps::enterprise agreements
:T:ptm::put to me
:T:wrs::we respectfully submit
:C1T:famc::Family Court
:T:pxnt::public examination
:T:ito::in terms of
:T:ypersp::your perspective
:T:noct::notice of contention
:T:rsubm::reply submissions
:T:sc``::senior counsel
:T:wgr::with great respect
:T:goi::grant of intervention

:X*:fScU1:: MouseClick "WU", , , 1
:X*:fScD1:: MouseClick "WD", , , 1
:X*:fScU2:: MouseClick "WU", , , 2
:X*:fScD2:: MouseClick "WD", , , 2
:X*:fScU3:: MouseClick "WU", , , 3
:X*:fScD3:: MouseClick "WD", , , 3

:T:cir::child impact report
:T:uacr::unacceptable risk
:T:bwm::bear with me
:T:jbwm::just bear with me
:T:jbwmfam::just bear with me for a moment
:T:wrsub::written submissions
:T:nt<::nonetheless
:T:iiyp::is it your position
:T:calboffer::Calderbank offer
:T:boex::bundle of exhibits
:T:super``::superannuation
:T:iwtsty::I want to suggest to you
:T:dtd::day-to-day
:T:op``::operation
:T:ops``::operations
:T:ykwim::you know what I mean
:C:NO::No
:T:nfq::no further questions
:T:inam::in a moment
:T:otc::of the court
:T:thec::the court
:T:sor::statement of reasons
:T:atcp::as the court pleases
:T:npo::non-publication order
:T:b4::before
:T:b4tc::before the court
:T:b4tr::before the registrar
:T:wdwd::what do we do
:T:iir::if I recall
:T:coi::conflict of interest
:T:csoi::conflicts of interest
:T:fcr::Federal Court Rules
:T:absense::absence
:T:stolim::statute of limitations
:T:ee1::equivalent
:T:myc::my client
:C1T:nz``::New Zealand
:T:fax``::facsimile
:T:p``::paragraph
:T:itcp::if the court pleases
:T:acct::account
:T:icrec::I can't recall
:T:txtm::text message
:T:icr::I can't remember
:T:xpurp::cross purposes
:C1T:NAB``::National Australia Bank
:T:appt::appointment
:T:gbh``::grievous bodily harm
:T:somf::statement of material facts
:T:imv::in my view