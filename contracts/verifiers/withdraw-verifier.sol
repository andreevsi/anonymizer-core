//
// Copyright 2017 Christian Reitwiessner
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// 2019 OKIMS
//      ported to solidity 0.6
//      fixed linter warnings
//      added requiere error messages
//
//
// SPDX-License-Identifier: GPL-3.0

import "../lib/pairing.sol";

pragma solidity ^0.5.17;

contract WithdrawVerifier {
    using Pairing for *;
    struct VerifyingKey {
        Pairing.G1Point alfa1;
        Pairing.G2Point beta2;
        Pairing.G2Point gamma2;
        Pairing.G2Point delta2;
        Pairing.G1Point[] IC;
    }
    struct Proof {
        Pairing.G1Point A;
        Pairing.G2Point B;
        Pairing.G1Point C;
    }
    function verifyingKey() internal pure returns (VerifyingKey memory vk) {
        vk.alfa1 = Pairing.G1Point(15335046661320124292905035647473127509866742556799957537393831346285102693127,20680079041773898215691568567745477138877933005294966282214515257262158223306);
        vk.beta2 = Pairing.G2Point([3568689028688573868995920093723292420246885966932167056583584626468088574871,16572806956827616158980549445834353967944308865810623123575771565769586741784], [5761958416950272891340940250950176129333966102015225525890184316726644975,8459134749510515866174683705762265391270287772895735752416833656715049479825]);
        vk.gamma2 = Pairing.G2Point([11559732032986387107991004021392285783925812861821192530917403151452391805634,10857046999023057135944570762232829481370756359578518086990519993285655852781], [4082367875863433681332203403145435568316851327593401208105741076214120093531,8495653923123431417604973247489272438418190587263600148770280649306958101930]);
        vk.delta2 = Pairing.G2Point([2922502782606428575313706789298971758931415232248977915726940392017197811296,16091888086371246603724553962075616245165063044494226092259127622531463764867], [17542944507852073656592944440048835908003068559795638530152819809602727924935,10466270494696629469139311286214226131051625181146711116261344374202227492180]);
        vk.IC = new Pairing.G1Point[](108);
        vk.IC[0] = Pairing.G1Point(5920711151909106138382390065529290035044911855647219757056523342508738246633,17459037657941419258874831521770986222243074775428681584469986060316866327588);
        vk.IC[1] = Pairing.G1Point(13163884884734959217796875427955984372054055734488431608136543824076230972608,18584375200464710646736864179209501133593414226887637078246636444394976982048);
        vk.IC[2] = Pairing.G1Point(1347354409989567676081169398440606409873172612770835539463004567079702573238,14214640118580507024447451250336915736049507392180618625035270753209231256584);
        vk.IC[3] = Pairing.G1Point(2812482698183262079700589584223270569908068511045745984840176183654574402715,2452763330634613412342768408297036270164204119015174806287417945852358739487);
        vk.IC[4] = Pairing.G1Point(8591344814788528828630574919068395019087503814071150292126047456462789305650,19908776224924761919689777766017847799005886758556055916758283704651657560827);
        vk.IC[5] = Pairing.G1Point(14970156465341383070883416308319551195459006669762630751504266470937492470185,13174419935034425671678730038717564677675678720579214632134762965140574651116);
        vk.IC[6] = Pairing.G1Point(1540713551065179317204484390858273518080447642496953281767124864812342649980,8875605201192348208817846586325843624781548914673660673566001842718450673517);
        vk.IC[7] = Pairing.G1Point(21658355102426705532983833600737744160299324817048068935611053218671712276488,11307208422693999699874688631826738651599730912659848775983874451146508160905);
        vk.IC[8] = Pairing.G1Point(21020916943018503826041117585201602381401879725943133801180424368542598497475,18204317511629165876035019340257750800663239106930110422612240646964575575313);
        vk.IC[9] = Pairing.G1Point(9039748088032952637867910463149916437234525445086982203679947489660288368827,7900583154307026345986813924998317142460544151516018839406878379802810603050);
        vk.IC[10] = Pairing.G1Point(11368574304169302013440303234114899179174069063489875260575045599701904152734,20547210927417312475459801516175936444408501500144936192955092808322108104881);
        vk.IC[11] = Pairing.G1Point(19117059139057755952881454395811150754994645395248610302797329511499241137436,20930968641458522633243674789566638321615702052686082207435571156706555173843);
        vk.IC[12] = Pairing.G1Point(6708468416157338559383292693063482946688471022825791618148367445469944296962,19646333078218613668498109297744122385657868549519995281765764120221924608223);
        vk.IC[13] = Pairing.G1Point(17447083572174581757609358055135123784244056194604792470143481209874477956183,10343369469402334329457350138961616133413696356931101410243205937646513003960);
        vk.IC[14] = Pairing.G1Point(20624752127917926501873807229011880314351477799429451923791674649626432857221,4515806559151988796722395939117140683735134712604208755168271206315586808067);
        vk.IC[15] = Pairing.G1Point(5405949162988786671737621541480340282652287763673314949959421982038076206673,3712996878176645375719063996526857620995961074360847566770437254007453705625);
        vk.IC[16] = Pairing.G1Point(11269405608679104151071484847855102880936513878731471289035431788238535353247,19784832368619629887416698850698047914918604816361184424732387772453881081664);
        vk.IC[17] = Pairing.G1Point(8838415558671457771916523905186029090330500169056197641510963237494259372227,3251919409394472416277686908930838189181102465088187485726580974309997801531);
        vk.IC[18] = Pairing.G1Point(18368510615473546032257806110933441232505066589971542525255443953326158284415,5880927696985393018650195709351553813350385036662317066341051683021791988209);
        vk.IC[19] = Pairing.G1Point(15682578838125388922089050937793406749418099966129404591687829858556528876724,16212323098264886717366958965810266440012668853319633826320350367872726384712);
        vk.IC[20] = Pairing.G1Point(21240813006535677356580300084721118765359914343519187789146474886602194138669,2004701376809060359894392358872926922161422066086672787574333954433436827464);
        vk.IC[21] = Pairing.G1Point(13909815456428771004963788408974082917628532952412874379588397986970000321001,411351972008819566409106939055494076105537129093838567016155451549823744408);
        vk.IC[22] = Pairing.G1Point(12285449325790297845799933852506668652117579430845098111206441470242204485314,17760508819612822200274703730231111167163937397421891816059558625653410209913);
        vk.IC[23] = Pairing.G1Point(917941414566250349323502294734893652266913816182562187579591805273272077353,19143686730433370991745261719114322782263495942971855038177842959667450664398);
        vk.IC[24] = Pairing.G1Point(16685596924666681004105452925321760790927257508970479773195408043919948303776,14007510801008186098248725109258566879210848019088460504114025801044701480061);
        vk.IC[25] = Pairing.G1Point(10413508088455464248023039976844176218612241066775103878872878383707364625394,6954781844655739427651866611680656868181389939882610960553539593611774732153);
        vk.IC[26] = Pairing.G1Point(3933368286399662713286783602756556155567066131759211969879592040828345388226,16512231060383859255628895492499928528932353699669679151499008607783921658357);
        vk.IC[27] = Pairing.G1Point(12503103963231691431563835916461576219234643908299860076739101143265994804051,11791636350977815169235296542509727009999524336154067350538381195372258619670);
        vk.IC[28] = Pairing.G1Point(20910365868257400066765437967183380381176365982544469146012483387527262794357,17493761583610559627674656229313165434800919744057202414849802025623528572466);
        vk.IC[29] = Pairing.G1Point(19633260980531352499585112254219988844719430677389730068753830204828522273463,9063946786390022286762172234094952175146819638831190575299280367257683221683);
        vk.IC[30] = Pairing.G1Point(8947273589787745576574783919383796697991520917947791297939081971690315284814,14821447833450977496143345292082848604022032854932954838134809036099464154460);
        vk.IC[31] = Pairing.G1Point(1485197257278143071992744024643822161442487598825068369526832196243220865500,11564600774338471938242197912098669365421033929300444054300341709719102355626);
        vk.IC[32] = Pairing.G1Point(2550062034352045992623654934571884672668929406867315105909911407947780120014,5371285261573211831119166873621489636504397440293832997199149827465471691960);
        vk.IC[33] = Pairing.G1Point(3013172176087775268724560473730355693123914884971578191205378831430235363296,20174090469490532542052089079476063476384535228289403092119737480209822528025);
        vk.IC[34] = Pairing.G1Point(20857832291644166595604223989124785375177149633921892479710501490115828954827,14624194348726700164752302566642428336792431700602483476437912098483080987657);
        vk.IC[35] = Pairing.G1Point(2507683750782072045929225136739442808760476964830026233254386711736931599194,16983545206976975972282058666300921317632134227233979805756515566927932635596);
        vk.IC[36] = Pairing.G1Point(9106464736228001476003096448533568091463358414455191335373738513333488218137,1148657227067108742428939275623413214991617687923984576764759360924058380462);
        vk.IC[37] = Pairing.G1Point(21542150729043102551291335966908648593107327615636360930442658087934782508656,5538975755179352205648568975155353769901525975274134905105356884505657710468);
        vk.IC[38] = Pairing.G1Point(4315524379361898249167433079730390636074567921519740674038051575858647932176,18746850820739901329081892781807934591604418485489198675245993397795874029472);
        vk.IC[39] = Pairing.G1Point(2061957364091283075702126267835087072790045365091394832611801136704442153183,21044513439690344159716619020043929869526809305424159387630523315766833007093);
        vk.IC[40] = Pairing.G1Point(775946683790050973960897785571723685071561847084191582216848528256641204137,21221384715938694478031023408518587103892746394181447179409077227114783326733);
        vk.IC[41] = Pairing.G1Point(19132059844212360387785987582042334585189628281626072272658774888605048247515,5330030539281868711045437085197619911287158382172674513406594010679337665629);
        vk.IC[42] = Pairing.G1Point(4812917953565835616861733711383588450603817787993139944025102854917608238823,17888707863642602427534499655693989995622264273607029382728591349090595160425);
        vk.IC[43] = Pairing.G1Point(17789222936926291379001400031357182447687758514595144184943051946434784403258,4895101571072642570279999007930407985977900520321758661426155969306617500866);
        vk.IC[44] = Pairing.G1Point(7853239793163655767858586410700756187297010012410300949419556295021279023889,14339190980742369831009464699435892550179450256980409014841151312266487398694);
        vk.IC[45] = Pairing.G1Point(9947617457853191213849015756050083638433468141531200242237647030362877733047,2322585666215601221146680740509873271737985958653373484475360958963291847759);
        vk.IC[46] = Pairing.G1Point(19748939990596109356217744288620061431049067817225012464431663120815414851546,11236876136316163713099686819433838703229247467213827638591305984782812118399);
        vk.IC[47] = Pairing.G1Point(8219523153133848123450733372971425213849990563644861287882604290960830139853,18686001272357243120384623353312093468035904234171422794375877966585328173671);
        vk.IC[48] = Pairing.G1Point(11333588942794827716497284634329147820432656740549079991082669684470448589896,13318378807856889616033948681574837661959520375307192173445057689376785236966);
        vk.IC[49] = Pairing.G1Point(7721855287178145414600336863618806440080606810404102957826129131726577222382,13698514695359866066230754566709052656735598953800093628547473131222868566930);
        vk.IC[50] = Pairing.G1Point(9530382036764016081350176725504815725065501924589560877346239481753965346506,9510968536625418120195520376479130329315962167333375022517370890870796452626);
        vk.IC[51] = Pairing.G1Point(12677420097470056818721761645379386415758159783793388772119101465569733682963,20698788264625654824593503391739647080179672481001930502352459491993696481445);
        vk.IC[52] = Pairing.G1Point(381737866396121081761782522590206641368579905697069735024413936427410190527,12766552028168981106576994677848021565018961123159528474434246024534030966180);
        vk.IC[53] = Pairing.G1Point(3732396638519939450141613734501761093142477461729016786185181664510476974474,19820642877976385524688596907224095153150746835754359312310560504249054682413);
        vk.IC[54] = Pairing.G1Point(8360170067346454375586730979748495285159973698976073893989854868656152425099,5835573231862907471557955583376923016624729041921693113304570054581124638251);
        vk.IC[55] = Pairing.G1Point(2191325143741738579497008708099958841344806774211596148602255464460404947039,10382984548690190497096749835094710933021611533283539592477558517763381163001);
        vk.IC[56] = Pairing.G1Point(7886666862411606143494433695005460125662455820497230039079795761424171501290,6458911222821109092706067011618968281570401790202946557939765519801340025870);
        vk.IC[57] = Pairing.G1Point(10502632257395137133857851224546328543193897603349844782207117030786719640920,12201556110568850147608927356537250991265326468933815637057469204840941308314);
        vk.IC[58] = Pairing.G1Point(11253653906668633319221437819861552155765925534073539805144053052965847900777,548828750396516898881896711082836832009536754672987435186370043860671454523);
        vk.IC[59] = Pairing.G1Point(18506289149087092462982022870577490833218313644260495020623843393339618762534,12755671799204931740793375936785653137061091595950558824243450537280465790354);
        vk.IC[60] = Pairing.G1Point(1715865158849630424061898434032280231720089168808571244068696557657450936830,13341747998990855108193991431048095662284429431485285639418355959114669665635);
        vk.IC[61] = Pairing.G1Point(8286801698681555977442046233678896741565660175326591805824800388765036466949,19335675304391853393339659243250597214322971469597886754966942060506209073163);
        vk.IC[62] = Pairing.G1Point(15697966454321465621626225479641126713503123717260351199383844009531409909201,18336552071635417880696537610381811318698921722256061390849766767475380320982);
        vk.IC[63] = Pairing.G1Point(17670691585133487206832877841216046728415945331032545508983107019174655411579,10361035659429966819381446874122208988571241399504843967029162679201491297475);
        vk.IC[64] = Pairing.G1Point(5723023989980592755698217204649645147529370998502716016068430008958103832125,11842246039120062976022190232538618605569627314267577925585538538360088739483);
        vk.IC[65] = Pairing.G1Point(11715490023441484119895295232659091646593137261243716988099131382993435311587,16601805059946333667225108138448072763827991268525365608476826542382718252214);
        vk.IC[66] = Pairing.G1Point(11149228832725958293418096965983480128770979011599192294357633787709258348076,7059704728212502937183960625584865237178724978730394947444594291978250906840);
        vk.IC[67] = Pairing.G1Point(8305688815471967921375396644764255285129168659216416505829467355366697723206,17888071200355653385127608417802435223276315107991217920256510846029784886142);
        vk.IC[68] = Pairing.G1Point(19719767471581931133412036164883512845260913179587965905863112238331337642598,14762326744184406120871770337246936533357250073081742315761042301859946858657);
        vk.IC[69] = Pairing.G1Point(11162777589210101334693238214706691228760410367284823570066832437821783118759,7962829128780344980868955486742200103982620711105289519428523603134756329727);
        vk.IC[70] = Pairing.G1Point(11802753408373994491612035750876416902067401382045196040534281549503743555804,373418516285512561435097105079806370011557447862340402417783240125460381161);
        vk.IC[71] = Pairing.G1Point(10022147647602903173669153377904019728858046994939714724773802948941008576238,14651381921267886163020943886903752437695348262595533162868117449284340958353);
        vk.IC[72] = Pairing.G1Point(9119669331000567297719937011674810899195449032930902867531446953655988053085,7762396570149909403534679622341498208950150644805047931816575884372079349043);
        vk.IC[73] = Pairing.G1Point(9106569732051533766215569874834700818170441011119219336204013245546928136802,5382757618811861719407976539101188407462380268155401770559819012544920204514);
        vk.IC[74] = Pairing.G1Point(12888167648541002800003618212623893859466996986981853364829240967379832962639,19717301770555225678394639285000038699877449181332154880459166408815152667782);
        vk.IC[75] = Pairing.G1Point(21155448108100427056336188782017967968506853941138772000006528326783673421179,3332332065592557073415384731279823979920340358653315341009723384534053374875);
        vk.IC[76] = Pairing.G1Point(2493216991034084675124300931722247841599712260758717779103568967741255432407,17823759167099727440765148809514115609628203355828169359154219981962303547408);
        vk.IC[77] = Pairing.G1Point(8152865478373531643805011314617059846654006479897689138766549571518191162748,10065332813931906643622719309635312020300050412540932824680222037858122396312);
        vk.IC[78] = Pairing.G1Point(2902813255585946064921085091860249229880628931343038531654929409136810540672,3950323766562100104133753754698304944888773892478174473637072900170601626652);
        vk.IC[79] = Pairing.G1Point(16670603908455633225267530573046739338128838963626117258153182361863793889857,6013519258950002201367814224169278029280129204041800273059979379418616463705);
        vk.IC[80] = Pairing.G1Point(19533430836470069189238070610696107967735852709112302737416127028814507008012,1106143942206708102165602271473333433329805668624609958606140245335405014024);
        vk.IC[81] = Pairing.G1Point(17075056506360212169176880594647598475919886525845200712090552169404747229852,17059134045625504188576860450312555317029116567467025399444697718570457991192);
        vk.IC[82] = Pairing.G1Point(9688318567495706911555539111849219989516079529069768309955755801755329922934,3642798253677384029379386517702796577067840989218283520159386970020494452745);
        vk.IC[83] = Pairing.G1Point(19779975303440538829021212201227594672180619118170366782435483453559957207270,3847052860682414689078457949323326121913183047804995359757903546785319422268);
        vk.IC[84] = Pairing.G1Point(4344223952819734843073873409584695812626369834224154555131456867669677598231,14589286662142700452892725946534562299960822083943027357323771208102723712362);
        vk.IC[85] = Pairing.G1Point(3781466608835311640350864418292451514029251646882434216978199547113778922747,1226500720199246566085326064126743254317567451975628570846752551285055308944);
        vk.IC[86] = Pairing.G1Point(11903413755576409743187777576053375460491016940790758086964760955357078692173,6211793184978660521059690038459579883591024792705072560479461622327125143028);
        vk.IC[87] = Pairing.G1Point(2110250070423676429981050096761841824691818942002634302241158582187404948346,14797954877166953358964911310617692626250726611077892781365763181239630924203);
        vk.IC[88] = Pairing.G1Point(9045539296658912644490347141082036954819963415173360516976390880691889812550,2195062478411479292392303769252304886791071884338579762179843646226990830284);
        vk.IC[89] = Pairing.G1Point(3913470228842679591584552651664738439340643966749535803913706466488984572363,4423370456577562452153146326835351169577146517222581498012524095519994233066);
        vk.IC[90] = Pairing.G1Point(3855998973598409183590878435825943206274878673205878356508817019690039981979,8660901996926523736683186299566042259870639587076590929794306808721549987984);
        vk.IC[91] = Pairing.G1Point(1347397548143051953059900260127190398376188639034045157789276723134235480775,3090725429137991753871799445172733860949221794934214595182672786701627709976);
        vk.IC[92] = Pairing.G1Point(15519068508152586947945385782554835883424933630874041824717378856335288807995,10618628609376378185440206315951778559507732617982550544118884863828531948251);
        vk.IC[93] = Pairing.G1Point(7713811040774507388351003651399626466441391330429933834524674992312789268964,14087584335918412692604526063746994445035745271060391058336304758350677791318);
        vk.IC[94] = Pairing.G1Point(9697200627566010803305464351322559435555461833381683892887466211213310499069,16521292401612291820094241013207384903621590690878801791456877233017594764215);
        vk.IC[95] = Pairing.G1Point(9655152744007178473925613000806905797097635879767695157985567083229155624138,20729456884715312112591323240628562508246072344246773406455506707466609826805);
        vk.IC[96] = Pairing.G1Point(20613305805227065645050105601427436228165375708088573127146822429963116363229,13905427358568979494736041455591061623992887827959550892948482808175273326203);
        vk.IC[97] = Pairing.G1Point(14075949155559072321082332003770116911698276141197648012711724968315389296899,16960648791654864017471047595878452518023050807013344964276730168398325418528);
        vk.IC[98] = Pairing.G1Point(19722863110374248787532897790215422580901637845043442182521965833504216405343,10657538346456760924659273269224551790753861917629431313523176719903555929478);
        vk.IC[99] = Pairing.G1Point(9651162223456968816357196019539571035154271571861081798037446044430402937209,5058089805448109224323883701380344398009870665012631997861859141980613661958);
        vk.IC[100] = Pairing.G1Point(17995053939583811185792860497902593114764886947995917718802169916184814530737,2937439557449277202130322481814029596679169064663636249211825706617496399195);
        vk.IC[101] = Pairing.G1Point(14184564827010123053499774305155197757320657312410691269036477592470714518675,6897078729357813997764373104674194056958565154641290305182249270519178945658);
        vk.IC[102] = Pairing.G1Point(7293389171159305303223630529039438694235837146997206219654685988592219227635,14197764079729336106860567788837040388575569433067254621805816476068400451562);
        vk.IC[103] = Pairing.G1Point(6866701736502452357920165994991823490374066177983721153094300386670493123509,4944938559685052869783125222823124237216713855799495563278462018410567070012);
        vk.IC[104] = Pairing.G1Point(15665819397577048459863381222672918036003027847949346031699382702458099285148,13861666680876785658263786144040576971918394478475386250656841164642718948189);
        vk.IC[105] = Pairing.G1Point(17184647475013499705210463232753956598307109165129045583262677379839060330714,13484423326581762547711487574820569995693719865522198016775255364337410610803);
        vk.IC[106] = Pairing.G1Point(1419821336052713310714805433035844086828936062541611660203710544655213495959,20621823258849753896188856354079347892886325212787345482819354255530336856726);
        vk.IC[107] = Pairing.G1Point(15851079307917051532694104295294653139666933851088145787188702688372298687285,19801328030710978309261151119732420866849800616879062245512571519187809859255);

    }
    function verify(uint[] memory input, Proof memory proof) internal view returns (uint) {
        uint256 snark_scalar_field = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        VerifyingKey memory vk = verifyingKey();
        require(input.length + 1 == vk.IC.length,"verifier-bad-input");
        // Compute the linear combination vk_x
        Pairing.G1Point memory vk_x = Pairing.G1Point(0, 0);
        for (uint i = 0; i < input.length; i++) {
            require(input[i] < snark_scalar_field,"verifier-gte-snark-scalar-field");
            vk_x = Pairing.addition(vk_x, Pairing.scalar_mul(vk.IC[i + 1], input[i]));
        }
        vk_x = Pairing.addition(vk_x, vk.IC[0]);
        if (!Pairing.pairingProd4(
            Pairing.negate(proof.A), proof.B,
            vk.alfa1, vk.beta2,
            vk_x, vk.gamma2,
            proof.C, vk.delta2
        )) return 1;
        return 0;
    }
    /// @return r  bool true if proof is valid
    function verifyProof(
        uint[2] memory a,
        uint[2][2] memory b,
        uint[2] memory c,
        uint[] memory input
    ) public view returns (bool r) {
        Proof memory proof;
        proof.A = Pairing.G1Point(a[0], a[1]);
        proof.B = Pairing.G2Point([b[0][0], b[0][1]], [b[1][0], b[1][1]]);
        proof.C = Pairing.G1Point(c[0], c[1]);
        uint[] memory inputValues = new uint[](input.length);
        for(uint i = 0; i < input.length; i++){
            inputValues[i] = input[i];
        }
        if (verify(inputValues, proof) == 0) {
            return true;
        } else {
            return false;
        }
    }
}
