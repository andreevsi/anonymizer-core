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

contract SwapVerifier {
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
        vk.delta2 = Pairing.G2Point([11499350886873694551002521997233794788909026165610222811946229939724691670285,13040404872603691033262415051769762138064056187066091576958415470464877329554], [11016419090364174812153201738866118077908011319921561335696272012015076090463,5741559768235483127396389299162716279491149298440747775513908312861279748756]);
        vk.IC = new Pairing.G1Point[](107);
        vk.IC[0] = Pairing.G1Point(15612395032381529738813329797812416442694264964041723137675331331550999509294,18436141759166724836985309982609765342195707645847124615110367786736890888670);
        vk.IC[1] = Pairing.G1Point(12955951137635923315888806324901314364790727607027983544212228213556377676174,13809101449860848164190771683004810867276492433576982360105972540947952278448);
        vk.IC[2] = Pairing.G1Point(690038081228659620806425452481753966320729096428563664417284568836615661992,5226090442525886259214857546188214902119841785116450480152132657896714273027);
        vk.IC[3] = Pairing.G1Point(8317713664255286735329748173738919511001646464050177797303525347341177967920,6506316668422670550937150344373984729134470217495620077085829902103424740761);
        vk.IC[4] = Pairing.G1Point(13452607133603872231434844853419627811200882843762920125973197138918499335712,284035975495521510658995963422346853019386765020676177683341676429610688377);
        vk.IC[5] = Pairing.G1Point(19237172004826426100706389694239746797913889591264704255651349479326424743382,4040397227007095573277250183404187410444412972040399906897215841313792833423);
        vk.IC[6] = Pairing.G1Point(13944692664735713071350083759449044791521839120011463065277841393197953140601,7465823818618105839763598815524900890321161776421479904728654297184518935370);
        vk.IC[7] = Pairing.G1Point(18426191407412452937214866499299694203207028249882104974458649937543381674063,3260624867617651500530495304481312445542117891499565681547122110454239716536);
        vk.IC[8] = Pairing.G1Point(13679610592758202440153921526069336567263191819997004727159456068934568036459,11918838340900387130364974128404350645106006296427553048448700962213441384789);
        vk.IC[9] = Pairing.G1Point(9852226301250673152501472734272974472183427120604065094091467104493147360903,6591162848464132416870997906648112676760647204129128936822292057277263106423);
        vk.IC[10] = Pairing.G1Point(2731132614935505039923651476007009430500837085150911814137735954164142983158,17411005967872211955292624728530896553417304653630008170385906461838936534485);
        vk.IC[11] = Pairing.G1Point(4499090575485080966445007074327239041038356264132375441203657790036114760089,16515500540148051921480021783721455007510636638220067454672496718765800356718);
        vk.IC[12] = Pairing.G1Point(3213143790280879133311885387136736114861945389100311167766890883940738176749,8265680146213804859342305499614213362048984835418134751667448919170051221441);
        vk.IC[13] = Pairing.G1Point(19216840343092901238789067921337745482967187314510631159370127511896763777912,578663462766458456498694338541547457830244657885839478021120854449338445435);
        vk.IC[14] = Pairing.G1Point(6221083110075862997442978877763996006432783359125398781887765723678062037692,21449149564391657559758082379482854293726001057745174929867563279825860052479);
        vk.IC[15] = Pairing.G1Point(19728469982223668750105430735065929813905781797773719449913570719412380426532,17632992345983924306020721852413116149438043273623039705811448571434015693740);
        vk.IC[16] = Pairing.G1Point(10663485303675381100147530889887662225374739690841403900698454157870854257243,6594206209837864020478907945055515176991461402849808935421257980038449621731);
        vk.IC[17] = Pairing.G1Point(12741428488261517858300576955950729213342935575401857640293931300863275440813,3801518129476717261051369237071988606983244810222869372357385327748141185621);
        vk.IC[18] = Pairing.G1Point(6257221927875056801850499819205130301277169858237860626858350836251172123513,13581473774939226617622586421264982225842008876983892096916558596204181193410);
        vk.IC[19] = Pairing.G1Point(10867867003795486818971550665238007408950955344188056699032798131223099482269,1688587317489346412106922534418907052877319977767118913871828457581781862354);
        vk.IC[20] = Pairing.G1Point(14303730230195326894457893734456920058993974938748377068417828593773605507353,17914310321983563673828675384001480131537489664130780538639114320978576863548);
        vk.IC[21] = Pairing.G1Point(6227664223126895545208650139334394328287462515247843956350772070244241932215,1252725092304228371352973451484598726177036462067630196621519203069161889979);
        vk.IC[22] = Pairing.G1Point(14996920689755840648637799224269550961673355740404120987729403354434445527769,15788467221149118306610727115437939808254987049790740337203457788260628751082);
        vk.IC[23] = Pairing.G1Point(19442562446975885284805901584356180840509695356195693698438975056657335836908,8495913948811255392812829663761540320381858355494110111450383760533922185301);
        vk.IC[24] = Pairing.G1Point(9130880175235989469124032395495663676376598301849580165426445770117320182497,689706134927444957138694055272295991592033799499622260824243172084372632957);
        vk.IC[25] = Pairing.G1Point(21209670237011201047808722185953833720884759351056348045502608104180306795956,20833429416905590235386248673258521757997180059644843365988767766812503020639);
        vk.IC[26] = Pairing.G1Point(6681361813801996051629928134797288465253760856303004131716523860631400397469,19806123946334608224301088855488923141737599186803207595811238647496875738844);
        vk.IC[27] = Pairing.G1Point(459281027066299974859447668635755615200104968487186919163683234055330820314,6838623707942583586099071553227879830484049256829991587643156345328326998647);
        vk.IC[28] = Pairing.G1Point(18633537900400443641603979044861840394570379743179165870747629198320161826405,18393733485975594637735195289235129046941408898483132229192902528299579991285);
        vk.IC[29] = Pairing.G1Point(12053581181333084391458679203395531810891817621642219470355162384411234968925,18399066560727619079934087443853535165110772267967741754396297464208202575354);
        vk.IC[30] = Pairing.G1Point(10019797082973082915409041931309779477394096912273053420251940506355661652901,17536770785122154919405619539522692918369288696411689179785813714884951004695);
        vk.IC[31] = Pairing.G1Point(21603251842563049197098407219939105824728747150478932324327564496847856248462,12228381382162767557651237959792792504197519962649771438065609987855075958799);
        vk.IC[32] = Pairing.G1Point(17817951760207679248288571229515772790241316263959054654061795057301501261217,7646950767699780041241628849511256089729147591023323982956702078240952189654);
        vk.IC[33] = Pairing.G1Point(4710748148132214746673601320864278328230859771669472123444173957504308946846,14110293642028826913398333869091389574965055574967009510951419156882165352817);
        vk.IC[34] = Pairing.G1Point(3350498979107425208792309136064646480817035323788687098895578211243407728513,10790356748064359587356412789142351564379946201279361207783992898850427701311);
        vk.IC[35] = Pairing.G1Point(17046533882390492484462765343522746524473999860332685959924135954499724577433,10704207623990541537324273119375464874452791547550992335490012674720546370282);
        vk.IC[36] = Pairing.G1Point(14135449310943831787634134411341509064311787810555244717206815072652098818225,14589046110231972386992962358311383994246520910683771541580352203348501072934);
        vk.IC[37] = Pairing.G1Point(9325856481555033624624518183033231981372595931530425492190669182416328451478,6706550001905456847157580300092576912359670504923143760584305799000647261104);
        vk.IC[38] = Pairing.G1Point(9650307234605519165016334464916625679270475469561593212853278609835694717058,2635787715868812100122612206211667801901281041288709211662674206024585323989);
        vk.IC[39] = Pairing.G1Point(9564546177983406515585133730587943316453650350231647042928294404257428048927,13575085212069848045759002842784171807968607953383965180095860325585313542126);
        vk.IC[40] = Pairing.G1Point(7793288873376350196218301132753794486535918614032282718774065144355215904724,17449127165217276016389213189694406086964273697656140105471911780201764598627);
        vk.IC[41] = Pairing.G1Point(393395526137133870405610113610707245863574384511164606706857680320122998478,2232511940608181841055884714815861038880737599372361296560518991509943183846);
        vk.IC[42] = Pairing.G1Point(16360796751772211042818286874359135763086182055727786164314432915004929747485,419396320041847354299487254813972132667300920531943851675799229362232908584);
        vk.IC[43] = Pairing.G1Point(5748645698731294026275574862488530826856810094866527406048179580166601077580,1375001367850417117745312890704931810048620134439366581935895234221585149871);
        vk.IC[44] = Pairing.G1Point(12624748243153180410921319943914291302374416872703268340390569862810360679615,14094977924954295202657129638002324390325689026639763630713947119795800256723);
        vk.IC[45] = Pairing.G1Point(12329749983328800846388023063745695295834127925414533795314961511795351168358,15123713684493628603621409507138912570054354758858388923721045114538087228366);
        vk.IC[46] = Pairing.G1Point(4490316136374546230210808439600511586436634984909669283572648831922690531052,17173681312403931937396693539116800360035489887564174011460958036162202977783);
        vk.IC[47] = Pairing.G1Point(5670853425905484625455234790665465847293541832543459169666938394762691235041,9740265840076243264591745044513580735075058208789128330193019646791175712206);
        vk.IC[48] = Pairing.G1Point(15269454199064577139515583070119257821022346118189024821992297563150111942086,10059515971051791404796915248863146184603721550923950085036344631637926095410);
        vk.IC[49] = Pairing.G1Point(16436843737788178868338569444210219548201290066923828980869029476927983499253,11862157379724024895597995523512969413714345723881910984504536067289289010180);
        vk.IC[50] = Pairing.G1Point(16957269746756140658548725378700486636787437010752538553459085753392078687797,10082428059267395015794471579857387455705697819990860731636349924758107506964);
        vk.IC[51] = Pairing.G1Point(2734927569808834970193957218073229793895862000869111902115712099906511451313,7691134107036578973334532170909625400375605900989118147153968236372179439217);
        vk.IC[52] = Pairing.G1Point(6484754348045266063993803720197225310172402647808705389500668847618786205185,4303157067961303960855293495179567935199746997865348586273147847579226658217);
        vk.IC[53] = Pairing.G1Point(20976316982761092592543288581920837330223324933704283458592249003657470474031,19366239823718918863557222716038292745684640144385206999139746864523578283607);
        vk.IC[54] = Pairing.G1Point(15945383601720828741203615651514264629637325706890644317893915386640589688726,1398643082149413248448032157747246841124655559516340678594440554416603667226);
        vk.IC[55] = Pairing.G1Point(20046138442086932420393521963902416569138544375379709596195339464258458019683,13034582890731424979473196277249402062702647018266636038009330373201119352804);
        vk.IC[56] = Pairing.G1Point(18521254636216783244249188032967026842331305160443154050942911869065325481966,2326980119413871411317233134464012365145558767350335055573706669401645786379);
        vk.IC[57] = Pairing.G1Point(12760612182784900369385529322650240672842532627741102040229443576251201895287,1062219065652942038286996307087432717702654089604807535715471962131778153627);
        vk.IC[58] = Pairing.G1Point(1798207137348885147107852636232545032607966748468605588273138281355566374029,16642772219378904817369778863468230676129747184058247133199154959027074959620);
        vk.IC[59] = Pairing.G1Point(8814802497263481519627669935663317959465816322041958210907195686939062721842,5538190623622725002742858015007550058500198234142405451633317062162058525087);
        vk.IC[60] = Pairing.G1Point(19574027158769889182835785071070874118726130924135173198721874385910621456344,4681229207299873763319819362590026636697862023494556870128913218561907570783);
        vk.IC[61] = Pairing.G1Point(15118429664568712319945074658614202459200467691773342353975423098263159733628,2049540223416053196339447909290964190326159493032528550336405594456520902254);
        vk.IC[62] = Pairing.G1Point(16103375542479438877439132288440795385284566175450087378309299486559174222121,4726764046196766883419914257440633400270956885837130349054382099881849895203);
        vk.IC[63] = Pairing.G1Point(18419527554911535985539760336495042283410427127417022228091400111115281299101,4760091024149525521830058952189604179708670057272917298968206838510982648015);
        vk.IC[64] = Pairing.G1Point(2068297455338734597034531144891763114554608087269846730187082465137315634408,9441212651034727062705383170172012856396911326270915888533345917750212852505);
        vk.IC[65] = Pairing.G1Point(20219384034379814147114493502585597993389798190205605445467785948011384770631,13590647750744882143738876769079304630075858034552134458606452595378660154874);
        vk.IC[66] = Pairing.G1Point(8898306746297691986534752662090471390345474863420408519472361492395620345104,13026792177072555747872958271403235195643784254621448130840457010717132022021);
        vk.IC[67] = Pairing.G1Point(4842078590645546951331842594741830429001539417636428091276762328146206733245,2235962978639533291663776408878387220474889914019213051063293020670665323810);
        vk.IC[68] = Pairing.G1Point(13696574730190866243343665886081452553900320652435117235474789951618497504111,11373681749349155724758077402079881368250280962621409317990319739705269484191);
        vk.IC[69] = Pairing.G1Point(15809623118943646965385561964935281913829687141667993578206178276660792271758,7251116605228598051417290673025368134538734916253015745096689024453563266342);
        vk.IC[70] = Pairing.G1Point(8351555350976410804559744047837997976070323434334505578733349761982004513455,7981805864442861251077282668970244049915500022341493306914331406069193686475);
        vk.IC[71] = Pairing.G1Point(10202007794839655896109827011208696813503385244056967386674275285515660049950,18389235886750971633240175755817177274340855945972077288263781895138827112227);
        vk.IC[72] = Pairing.G1Point(19992228161062538087363050911018182263704538379164840854730074169084977528410,17856763371063696482680040143150573769572846903339451458687741164695471867697);
        vk.IC[73] = Pairing.G1Point(835555425079182022373423458215989044434541660433423535376629417303852141976,17712642979257364238794820771041488782836385674568633080487512725038633527396);
        vk.IC[74] = Pairing.G1Point(14007209561838498660622124659795122919806581665734340706923900220237140593332,2071487260518272950073080937490059007854575874638119787499836272804015639025);
        vk.IC[75] = Pairing.G1Point(20063472709466629678942272911219136273397211149295383786630069354367723771619,161267326491107538621735144197206954375763633361769069454137830935331084609);
        vk.IC[76] = Pairing.G1Point(8780095790105665635046981572273086705084350326532476980006469566057270548040,16164840666685787037702917654298834389444705628149930748115622630862492027923);
        vk.IC[77] = Pairing.G1Point(14164341288197839281162406479864756624686544671133614360750833219804425847296,2668653089358479293679874009866748092527461842417793688690581767402713061789);
        vk.IC[78] = Pairing.G1Point(13150991076336067864008847251959736526082281727597846972179859739885181749982,10821174187606357568941560069390711726971998186620412389569844887953204770381);
        vk.IC[79] = Pairing.G1Point(14645514182745151611823541862948595517099442494947642896118064255309669788085,15737761870488561950415395708494886760564471019900940713069751260503145602276);
        vk.IC[80] = Pairing.G1Point(6264160792135025696500788233806677977640342138084368434017048663560905694943,8932304418275655635521546362596425452765472595664053132807279322627359569858);
        vk.IC[81] = Pairing.G1Point(8354233946633249173142944685869200455189382048350459449692918360026586254311,9441410035577217541619824102840205852504743265227163426553671673389227482057);
        vk.IC[82] = Pairing.G1Point(1323171076216828799078442186363851693965466669009019159887160276140980417442,12312203789609715902539292663387021581168445440016950139171707927562271637067);
        vk.IC[83] = Pairing.G1Point(21478974703614145195543874300170991245809368409547575690833928283324371796561,16117520009754736665476834711310675938632994730968107406538581872868349619350);
        vk.IC[84] = Pairing.G1Point(7827784063328596618792754464545274039755026895953297690114115512741840100373,7644811371371364308251792191118569519438450676509783764303920540811875784314);
        vk.IC[85] = Pairing.G1Point(10272336659832951867267973893069737936897647467083215007260927361227834957350,4918709510624087156369563613493607800261231383134586951616504667110866043017);
        vk.IC[86] = Pairing.G1Point(13591074015228879009295800922003262793095164431126774145398785199503035328023,5992298777874348685733208620049068941396706808572708166318913847651869997925);
        vk.IC[87] = Pairing.G1Point(11256389622090973763213839882013424522175831572402116783308828988881646720369,1758327301538906001318893309194756872407257710233601560416334795037767465678);
        vk.IC[88] = Pairing.G1Point(21745475022155960222466780358031162993788710469240950655425811885665733290942,11772515102553202244668191934779344536568017041371038798369693530015325754464);
        vk.IC[89] = Pairing.G1Point(13298626157899610354805823440589318393356144085008209770965670754426595502590,2545474078345449588707584961021311218288030402374276388932453107439908114494);
        vk.IC[90] = Pairing.G1Point(10698757332048644198973518021061557582361116414013763209351818112220630574885,13569126695236218579199301822174086037503057932868382560980308338944150257880);
        vk.IC[91] = Pairing.G1Point(6738359771683223655216602483186170188224910091076469493597092324561809331843,18219580614019014088641882916079866573979500754229021010032826475260950809329);
        vk.IC[92] = Pairing.G1Point(7968552076749964435734263627994344577663118686018945823063823274308811262141,3868643327208672280702253542760335561604073788633301819037199553956370768435);
        vk.IC[93] = Pairing.G1Point(3107573881346213683311961628448140330546228344148507728037878955498246979836,5087911005328882833364565578207373668160378205771381110207734614369242421480);
        vk.IC[94] = Pairing.G1Point(17061316138780480945865830840707508382212072408050969767994428779164834627974,7993315334961798965917538246621471662914830818969703815805431146756001573558);
        vk.IC[95] = Pairing.G1Point(19852936699995663239552419904268236440097982395847228243588681853919445942627,5976837826519994655508563568445431296362362299044151009246536943447889402599);
        vk.IC[96] = Pairing.G1Point(14913475759870682167273088451604325525594537545668887925278198320321818218316,3463849805503126979715251838072275830050370081739518233312541941478785788497);
        vk.IC[97] = Pairing.G1Point(6042118336099705463440510469852570840364815675532032918896570919902186380204,19635615364755000831688345380716276736068303354802207622314277087097272431994);
        vk.IC[98] = Pairing.G1Point(12550951148244607774749137767400065986809101690383377699646227139775764269508,6178499977490858228128648156268936324919246051745557287622356518793155439112);
        vk.IC[99] = Pairing.G1Point(3811531323609355100565014252174193757397331453285679650369066317987447599635,19720518501097779973280107051902593202310569219266198505883211735463097269394);
        vk.IC[100] = Pairing.G1Point(14883397581308007337785788756549272468757113015827626073849645627187815112347,19529484077474599348476666167232745037900168912757456093301627907139396279879);
        vk.IC[101] = Pairing.G1Point(4927503812911909270031939352958576402466494453705144058833626860278656432010,6940789329091303499235511720982243571782462790116673534798304128312563374357);
        vk.IC[102] = Pairing.G1Point(18427159161764889720881657663362280387824117511606294096854713484229847312939,9475908940518985396955411636442709730105057255688034855248171818570109162534);
        vk.IC[103] = Pairing.G1Point(14173523772391163111150639503593690116655481474055325423531784585683108266483,7193005118420254135316263390957350934606013744627399799660344403064302323908);
        vk.IC[104] = Pairing.G1Point(6334038192627554926815997018718236118694439149889232689462312842407737114875,19643931594130449696717766040338798489603657497565278120871933195418088446318);
        vk.IC[105] = Pairing.G1Point(8176396690384920257641975665485387841667366877653931207427910765059466926003,5521956012873064016758974333785654174079610021569871842497407745336887425135);
        vk.IC[106] = Pairing.G1Point(4172153723658576611115047599860890848188062914728621807487681787954730974251,10269437671247553167772294278865303609571245310380142713485737885958127618029);

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