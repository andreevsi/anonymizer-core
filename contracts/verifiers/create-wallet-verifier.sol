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

contract CreateWalletVerifier {
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
        vk.delta2 = Pairing.G2Point([3722031434778123773668578767356138675981152780815807371783518450754532926527,14141893887669312679875383924210442763377551904621766413634549005530182010311], [11660067872538877151389183995577270391195289220163373884013947819494810997906,9148887152492758319483490663611208051383268241786566295692272036718952671437]);
        vk.IC = new Pairing.G1Point[](102);
        vk.IC[0] = Pairing.G1Point(14377012928923844335188269663282116953974197974796648948829563342900516055232,3716271183149123566383513023418469141673936682244502415576010825907736871908);
        vk.IC[1] = Pairing.G1Point(14537219619595724649215996468928184047238637127893882484928561203747165797061,12800362915253590107702113490353924743717542896510950273653540388579769601062);
        vk.IC[2] = Pairing.G1Point(5323851682794332627506061573613924785080086823470009571136461658902791470246,11254486854154256057743491148352761612550188318945160089160844294412751256338);
        vk.IC[3] = Pairing.G1Point(9220311349622499652983692041643524170632350529698559260943084419264501622134,4564884529134994671208465022505480764393362482043975639348462025385891613461);
        vk.IC[4] = Pairing.G1Point(14198357520659085310292681510895526267336975801909951274546559047462599974143,17555392681409314012758127938787230357270710945873610262091608934728953616458);
        vk.IC[5] = Pairing.G1Point(7482342275100630078445183096015861009380303248290568652565842087518693840470,21070015464851568446216722464572524919315092500067810670740463315166543452591);
        vk.IC[6] = Pairing.G1Point(12120274169126248285972255520578347082157537422766866288351669401129526505457,3642315566549807582827889240589375385824126236305544898976577097163625206252);
        vk.IC[7] = Pairing.G1Point(6290836812217515806495270097751065757458848099977810161449753165022734722558,4241618755936466102111057419746637520900240999331703479940611027369217480530);
        vk.IC[8] = Pairing.G1Point(10479441650912567159856197188842190165557195588706822908480534020367965954873,2337917535060308164367290504265040514390109345767254845039284471048243060481);
        vk.IC[9] = Pairing.G1Point(13854806296001266373979425283681172054406531132197407121255815761216179778347,1122993057670437818711028137784849090717313357405748438548480214236815917429);
        vk.IC[10] = Pairing.G1Point(1291034537529476030224684774278875635289834547930885124163410351846353576640,8388534511370674787191953174489274983703651558050671526622435884042536682368);
        vk.IC[11] = Pairing.G1Point(20673588581561900765075676894820215775356479552560870172557121018607673834762,20659896440355653231556238445425297382992355994706245805198534849534468158606);
        vk.IC[12] = Pairing.G1Point(16501594030269136557771809382232349885958939649941612554815291321975556446430,10011489134143501422142857101402261599538334419507131037988953190380140788502);
        vk.IC[13] = Pairing.G1Point(6689077396466942675462369107000661634903111253806830923081571416550901511129,8723252656795527291182748457007610549159831614120684801049720360897823728009);
        vk.IC[14] = Pairing.G1Point(18132765882768053084315864714656863852357993995586179132973409233167550461129,575841580460745317261017854253751890673329352257999850271108494418424907959);
        vk.IC[15] = Pairing.G1Point(19948141513401440864793025746350183245047751929434172692055162838562368511878,20909665510438977190712794935243875950653161080176833563602466519461520768025);
        vk.IC[16] = Pairing.G1Point(1667383021335394799237447302771241770887855897167423937698683145434170371652,18939277401016647728194605756920183680603946134862071580833937473515101590882);
        vk.IC[17] = Pairing.G1Point(4879704634949115433395976385281575048697066278440509920385571403888227794982,9691113577784451205041536555243102305238316052625854045758571680975200454798);
        vk.IC[18] = Pairing.G1Point(20929947629621643900240197988681787681888962549114863288292474077989014499597,10410694688657013098914369972599621707789477033867167741203045010830403824441);
        vk.IC[19] = Pairing.G1Point(20525895171072305742961999841403303731166194072037506079983873066979835644453,2957382611714090134996473590639613996894989151622190775471336257938929217776);
        vk.IC[20] = Pairing.G1Point(10939698665817906658067427148176939611581125090369817257896220441084961388389,1126049540053698125768596417016852067860124155244156521492409424282254598837);
        vk.IC[21] = Pairing.G1Point(17918086577084567984346990559697285204617543398888639375654775171495648037140,12764654089173939928461341065667866618294450738473098099968705840536100721117);
        vk.IC[22] = Pairing.G1Point(263949985334655650842853949542465707944070316807083725559579950593695772455,7888228782470940690825125250321660203828497984502897275815523310385971991050);
        vk.IC[23] = Pairing.G1Point(7395821738324429060921884011690973222015520913393534979611715987707203987043,10283192865262223721170600250339852478413166900179374848535805681120353159123);
        vk.IC[24] = Pairing.G1Point(18910122808898332832460833948806212759966607680704164676113562285940740391167,5040543927818570427185991696047413589586219636820036570782886476123148580000);
        vk.IC[25] = Pairing.G1Point(18926407508672620054574621497813902158257869978891332780992364871561712848104,903708910025702344897266644140966795429610636868274778600522188159277491410);
        vk.IC[26] = Pairing.G1Point(15783300022862390495080265224763225353344115148474174677587118120262972295409,12356364422240518559541712048322668356153404997943905537971794674622417187233);
        vk.IC[27] = Pairing.G1Point(5824386419048492819516523512212343772033097961462622462809617888193771641518,5636600444916433567574216217386491786143531023022245625245206137682742644240);
        vk.IC[28] = Pairing.G1Point(15380595204374170800737971094792857077040248721423339967936542222259957753417,1437681253755480694589872306099189652184036649635010281769512638727690479249);
        vk.IC[29] = Pairing.G1Point(18060598479076416653864983834231152105961755686848762407341437022337466760033,13856616339728715798091827642920041955965032502686288281918138255164873185441);
        vk.IC[30] = Pairing.G1Point(2083615481114228226865563968830730200024283943687019239399518690491648595839,16638849359299046199836874470598414750592270960807548684417853038074060932161);
        vk.IC[31] = Pairing.G1Point(21233610990619767733224876273541391865923813644013686664770454303193655424858,1697439501537061421983592757027357744219907927515990673219898842382202831222);
        vk.IC[32] = Pairing.G1Point(3806935032587540624005782588515540798479367181805867379521357904872465500416,12940642262100183594318286608109475231017911163261003183062780570844846026845);
        vk.IC[33] = Pairing.G1Point(9941687405190472932154659096768477932895964868231232752516924824086085368268,21559057969757149087338115329373852370042220599049986032856739421477923023168);
        vk.IC[34] = Pairing.G1Point(10013046157925209642689423113567777729625986724466277999801387204852864359929,14919220414585805774775026740030764165483974399682472134582850620285003804043);
        vk.IC[35] = Pairing.G1Point(20546686007814114937866490848290098616857122015296322404785772169443412050467,7581931991451664569949100147914937313495706741962424187993718787754979995262);
        vk.IC[36] = Pairing.G1Point(1317809177531988868561766494161642531826760705512087986790195353159492503015,597612701881689298395098584570417212588010291649007245211722694815441954165);
        vk.IC[37] = Pairing.G1Point(11061051192394727617369913320058270958388080754123195874360152653787677190282,13511050933810528085861894408227911180856260012601649770245307746492172466614);
        vk.IC[38] = Pairing.G1Point(3942972475752236931907394978967480609575500140031509024154431454217750528588,7001116695827942095005763396380125136281024883824029358504409507108776561459);
        vk.IC[39] = Pairing.G1Point(9949692489098893126647703799945689060611320045295896423070484119827162704120,9778428675892603888874449441995537305248423019992281656378194726816504823771);
        vk.IC[40] = Pairing.G1Point(2958641166357558027220738822246812298364240540948189409672969786482657498913,14172973106282355441873255758798504238708066551487006947388524264653665377490);
        vk.IC[41] = Pairing.G1Point(9135693168344100218695244211461343819132960768964934103778355920435485634773,8059090440746659909111395030922268227197401875091850676509500632342852009808);
        vk.IC[42] = Pairing.G1Point(3393278152287082465015888005848819354053799090969056450046370412988239425263,9355993976186878302970956153660762267675041311784924051981618529754232581376);
        vk.IC[43] = Pairing.G1Point(16431608297962627552731865995552828723518558751267763945771581363649797392449,6244930242212448776227402589228045478891105517867425357360654826236026708603);
        vk.IC[44] = Pairing.G1Point(19401892762337311451554371717074883538417947021895527579835031697740152242255,13403596231883043241506150455213480311632742488272966578311776396654696089814);
        vk.IC[45] = Pairing.G1Point(20666033764717815423652138932950290412863576443881300131718649452089037132753,15740049580655477325801419361071651112882424131729844515223533489643755863724);
        vk.IC[46] = Pairing.G1Point(20189871024928513984696140383827319374241977767838259819653031471589298099246,7161382770383822817539307414860128540765350138388125700750914717942490355545);
        vk.IC[47] = Pairing.G1Point(2646572389957182734501606667002125374694900711698798648410295253446537425399,20424027755200688239566691443654109746949373290672005151541184423006641228428);
        vk.IC[48] = Pairing.G1Point(6862624224760598563833974246296036408492862265832674939310840669593201325247,13642519491801511135202106967714265773179918458621323121931427800931163477566);
        vk.IC[49] = Pairing.G1Point(4600386756034497121324389026814794201426668248854224950227747660710257030876,20902781093316651733670645087619417956118551149285568669195031531629570393444);
        vk.IC[50] = Pairing.G1Point(2693337683380432055249550734863787915059090799994532868398396861879608346966,21873354068031931245924335803616004034596841289220657903064008465906664432621);
        vk.IC[51] = Pairing.G1Point(17313069754057321399331542891398357209647626802448548895165611499444745113834,15299666064977086493486201120781106346657081320249716558795814571806433335877);
        vk.IC[52] = Pairing.G1Point(7825079491521414404785228606452914681746874877689542460117347267611301517310,187409527268747321723360762829508564355206438000401866178027604151741224405);
        vk.IC[53] = Pairing.G1Point(824125150527559971121964376729541618086730902148689582048620433650420395132,13677392323611369259517885864159896009303184667172341334526659979697469687492);
        vk.IC[54] = Pairing.G1Point(3565027363164893375354854210636472785508117263974267038984958688848131687514,17906789129022333579441725892139778670337018858400504630346449989288472291647);
        vk.IC[55] = Pairing.G1Point(18103363174081680534220834504872623263246182284921783496299275039808343040922,13800878738531961368645082055856110047324050869891307650974179987753080710138);
        vk.IC[56] = Pairing.G1Point(12356516831440045934035491909345780345326428331505329686442050325704059650261,20941156607730320830045530349619013225214508681283626559626701056129200870495);
        vk.IC[57] = Pairing.G1Point(3005088945295729965078786515835865212999774111918740917383735347896938117624,21269919801394464907612074379797634809691024850930280357239417637113956804407);
        vk.IC[58] = Pairing.G1Point(128450021148988939612817899633347837584480662594938259547757217203527206680,16698582106642059008826577709778168275039641947191590201874651683812260657104);
        vk.IC[59] = Pairing.G1Point(20339978719614122453253761494638257992520549271260323741921798151872524408358,13747461813339272868645967479607605365189494665189413745220711217141308202493);
        vk.IC[60] = Pairing.G1Point(20694277881070564756710808029796987750678593135875606422517532224867697872547,19670260663431386548852152372441654934287468400009782700157902392478741656443);
        vk.IC[61] = Pairing.G1Point(1687743598539808749939905550373214539874979527945974736362935770456979789311,7705828911766525125601068542556320124537461872140254130923426717928495052925);
        vk.IC[62] = Pairing.G1Point(6531049084465549993686155409022464545667998968969669511970670095716752055078,4112888162708126572547937742270071325017110672609930665113109780284405566484);
        vk.IC[63] = Pairing.G1Point(11569686463988274670889887622099597899325443495599058961174606850772228857186,11410442084880627774404154576493290274905318992706164790182576735302665004706);
        vk.IC[64] = Pairing.G1Point(2376351416129771799220303030360146116341630357742606913710664927103083453543,15848994222059211971153793095182477238372025452362620493157477292624418771045);
        vk.IC[65] = Pairing.G1Point(16558339827876473924900973705521650707475235513305755461781395428319145061256,20816161826542119864281282750895707927596333302673146186761265641665120024674);
        vk.IC[66] = Pairing.G1Point(9243661019769234068250515044677463442614358901068506758013926019383927342418,8252707563858751244878528759875545108289033604691226892554195060706300192281);
        vk.IC[67] = Pairing.G1Point(1465071899857078939936448485317978644186125436505956509518293495554579240856,11296892325151997017188956377200930932835212769570631608860561920960221598139);
        vk.IC[68] = Pairing.G1Point(16496622191155374993393568703367432405294249936514993099652163466087804936238,5247101252574458550322713025080758646038858399224336456692807491610655682260);
        vk.IC[69] = Pairing.G1Point(4422444046274542753344379790606679395085511491175777801208131771010999461835,15192698968637142918693194226509169594970084593530988692606987200768357136198);
        vk.IC[70] = Pairing.G1Point(7347480959119817735080360364727159564942901687399698666307689968805942940638,18581971478170136199749527459682229522452152124487470925204249054762582652496);
        vk.IC[71] = Pairing.G1Point(11710357796584391874399297883306267763420372649199079720766958971683631662340,10774813793558080571745903395937544115131924709800021889920939277150869191572);
        vk.IC[72] = Pairing.G1Point(15213442311814124110735620848778058910400460837371582975423359519448292560028,16365005615069845826314391322429798199290469723296966507832142566572930037292);
        vk.IC[73] = Pairing.G1Point(9130819527771560552752361359182015264947146664976531084539386032848542086968,21425801589592712022639794443065036018459821182603718044154996965680451964502);
        vk.IC[74] = Pairing.G1Point(14082004846119821278387046502974235557707317535076923969653567131161645361,21267970254630891367145465659741471213791515486652012957941238786033397984846);
        vk.IC[75] = Pairing.G1Point(6458244140108843242135632686132660172158730143404290027134424619659382244142,7057767279356379164841063924884212919687988666315591225552569651545554793139);
        vk.IC[76] = Pairing.G1Point(2333159059771923239667367956313573260300606116398982520879823395828097070095,20026407877101942402621948947297288780447214666224052648192940226355333421515);
        vk.IC[77] = Pairing.G1Point(7701394134735884163795757247948010408130664012953564896676810866433072562256,10140303947423122899761779024511451453848139856525485113176121834038084120832);
        vk.IC[78] = Pairing.G1Point(1488839186218409323206371703601744849966949574256873842297047442543465359390,16027702128972645701226949339935976030262590567539673268426329263570358585250);
        vk.IC[79] = Pairing.G1Point(19960548065143195378059425118280853168028328641491161297445703203042277136737,4999053827592204440630995001824951012156372033755346091992882308168647914935);
        vk.IC[80] = Pairing.G1Point(8484313492606142834845923648984337025525115125349269409286573359795255977290,794661176437311072280853983946584409210601128836665987716682762712654792585);
        vk.IC[81] = Pairing.G1Point(16119517795280604720574709749456707647651936424506003553696010947018121869993,20072812593197711461692901394905450036870084352112145179462786107676421671668);
        vk.IC[82] = Pairing.G1Point(1586809201430742824958571139474903825744014957922427357221086622979217826199,1428097648508622277203041867349728510472123696429974664299268699481248834701);
        vk.IC[83] = Pairing.G1Point(18439436077361275159013593137816411426786809855231858409904387256059567766425,13455003470721658757323396618083211628908753490033203267028054668227515385159);
        vk.IC[84] = Pairing.G1Point(9451601301239775838123670762326010079436949808211625255968765057290703911432,17994745201369556839124703589369139473098063816749410980530496039511114208571);
        vk.IC[85] = Pairing.G1Point(5452795605459116276244673779292895044235300288165561514469176356970988786823,12316898828498315989689853310908411909307393361319713500129669620716510320941);
        vk.IC[86] = Pairing.G1Point(11203990277707389128406996402902631261054532686986206563714149336241645101258,18541499396367410779788102821930973686082928046309134075502524090286620897246);
        vk.IC[87] = Pairing.G1Point(9181232271890112973169214741896299008365141459970569500494398718712298085157,18827542833902521572912614123366687960238188716802063825991492369748286111509);
        vk.IC[88] = Pairing.G1Point(21046034844190213504380247462544447741135799185282862174472336983496773498986,17891244594569194640270776453293796510289148651635369446024379043618720094540);
        vk.IC[89] = Pairing.G1Point(10613577792969190531687080679832645467887618496674296026796960531328188206354,7445600592018235943833359300039422558848661764238025805580750497188366792687);
        vk.IC[90] = Pairing.G1Point(1036306568985428668455557469659122104830781039689331069899462784120346286312,12977444843892757059892486476714792383576184718890459635917900838276024125453);
        vk.IC[91] = Pairing.G1Point(17543016976220702183578018956167416292084209476232897880990818968571762136281,14698660000615599160374396180621938562528049708215180873532498019801803928530);
        vk.IC[92] = Pairing.G1Point(6502617369533250775557623172321041547929458303018756180022008625835935965454,9138101338557221284035715866909639374220195574067179468837824652295062323243);
        vk.IC[93] = Pairing.G1Point(14781535912082234366868247383250127687746153662632596533528913257189859338821,14693259146648462533574697913657547681770865873806117430787042161289919489089);
        vk.IC[94] = Pairing.G1Point(9636630032918398543515497969849491482060889314686150546747515101230934584523,17111947889093956328242800544790958813903953850606685960212610725873778245505);
        vk.IC[95] = Pairing.G1Point(8639884504624861496819166725614157666657741831366526110088749309236356406098,7307915387197160626523430802153816074203693285449015350536644827925285152450);
        vk.IC[96] = Pairing.G1Point(13056688882726024062925492373290099250186002656777548671684642786141199249827,19272913609213449815051230443523235486048433125979488458076803886077181331858);
        vk.IC[97] = Pairing.G1Point(12693838553745161397499841171675114272881296296761686474712647535599660102198,10708544153200872238422275017940709505066017863474909445844502282434511406410);
        vk.IC[98] = Pairing.G1Point(6189744537116998994625886519132494927756114492876026278841859361878209882754,13152112277074611524063135798602698224467172707376879209426525419714370462593);
        vk.IC[99] = Pairing.G1Point(3178687819828806553841609422802978026799645277925256554024904500419372855760,3798323157419935184138295579066313124066748997663760697565166215379079282582);
        vk.IC[100] = Pairing.G1Point(18143568620418081130650776709366785312705238430324748448471487582002731220581,10560530325377680770740306004053774905604710577307180701681052828227115351866);
        vk.IC[101] = Pairing.G1Point(10203611427171466984576137370465868824898835381560449151990187485149122319704,4566570118371251160550070897717739265478405649594429096851941514889688183743);

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