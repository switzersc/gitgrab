## Using

```
require "./lib/github_repo_analyzer"

g = GithubRepoAnalyzer.new(org_names: ["codeforamerica"], output_path: "test_data.csv")
g.get_the_numbers
```



### Code for X (or related)

[
  "codeforabq",
  "codeforafrica",
  "codeforafrica-archive",
  "codeforafrica-scrapers",
  "codeforafrica-test",
  "codeforafricalabs",
  "codeforalbania",
  "codeforalgeria",
  "codeforallireland",
  "codeforamagasaki",
  "codeforamerica",
  "codeforanchorage",
  "codeforannarbor",
  "codeforantarctica",
  "codeforaotearoa",
  "codeforap",
  "codeforargentina",
  "codeforarghakhanchi",
  "codeforasahikawa",
  "codeforasheville",
  "codeforasia",
  "codeforasiasociety",
  "codeforatlanta",
  "codeforaus",
  "codeforaustralia",
  "codeforbabil",
  "codeforbaltimore",
  "codeforbangladesh",
  "codeforbasra",
  "codeforbcs",
  "codeforbelgium",
  "codeforberkeley",
  "codeforberlin",
  "codeforbetterindia",
  "codeforbirmingham",
  "codeforboca",
  "codeforboise",
  "codeforbongo",
  "codeforboston",
  "codeforboulder",
  "codeforbrasilia",
  "codeforbrawijaya",
  "codeforbrazil",
  "codeforbtv",
  "codeforbuenosaires",
  "codeforbuffalo",
  "codeforbulgaria",
  "codeforburkina",
  "codeforcalifornia",
  "codeforcambodia",
  "codeforcameroon",
  "codeforcanada",
  "codeforcanadayvr",
  "codeforcary",
  "codeforch",
  "OpenCLTBrigade",
  "codeforchemnitz",
  "codeforchernihiv",
  "codeforchiba",
  "codeforchiba-incubator",
  "codeforchicago",
  "codeforchina",
  "codeforchofu",
  "codeforchs",
  "codeforchubu",
  "codeforcitrusjunos",
  "codeforcologne",
  "codeforcolumbus",
  "codeforcongo",
  "codeforconn",
  "codeforcopb",
  "codeforcroatia",
  "codeforcuritiba",
  "codeforcwb",
  "codeforcyprus",
  "codefordallas",
  "codefordarrington",
  "codefordayton",
  "codefordc",
  "codefordc-erda",
  "codefordenver",
  "codefordetroit",
  "codefordurham",
  "codefordus",
  "codeforeauclaire",
  "codeforeauclairebot",
  "codeforedo",
  "codeforedogawa",
  "codeforehime-u",
  "codeforeindhoven",
  "codeforembuguacu",
  "codeforemre",
  "codeforeritrea",
  "codeforessen",
  "codeforethiopia",
  "codeforeurope",
  "codeforfaisal",
  "codeforfloripa",
  "codeforfoco",
  "codeforfrance",
  "codeforfrankfurt",
  "codeforfresno",
  "codeforftl",
  "codeforfukui",
  "codeforfxbg",
  "codeforgabon",
  "codeforgambia",
  "codeforgermany",
  "codeforghana",
  "codeforgiessen",
  "codeforgreensboro",
  "codeforgreenville",
  "codeforgso",
  "codeforgunma",
  "codeforgxm",
  "codeforhackensack",
  "codeforhakodate",
  "codeforhamburg",
  "codeforhandai",
  "codeforharima",
  "codeforhawaii",
  "codeforhk",
  "codeforhomestead",
  "codeforhonduras",
  "codeforhouston",
  "codeforhuntsville",
  "codeforhyogo",
  "codeforibaraki",
  "codeforichikawa",
  "codeforie",
  "codeforikuno-20150209",
  "codeforincheon",
  "codeforindia",
  "codeforindonesia",
  "codeforindy",
  "codeforiraq",
  "codeforiraq-najaf",
  "codeforiraqprojects",
  "codeforireland",
  "codeforireland2",
  "codeforitabashi-org",
  "codeforitaly",
  "codeforjapan",
  "codeforjerseycity",
  "codeforjesusamen",
  "codeforjharkhand",
  "codeforjoe",
  "codeforjoinville",
  "codeforkanazawa",
  "codeforkanazawa-org",
  "codeforkang",
  "codeforkansascity",
  "codeforkaohsiung",
  "codeforkarlsruhe",
  "codeforkaunas",
  "codeforkawasaki",
  "codeforkc",
  "codeforkentuckiana",
  "codeforkingston",
  "codeforkinokawavalley",
  "codeforkitami",
  "codeforkobe",
  "codeforkochi",
  "codeforkohoku",
  "codeforkorea",
  "codeforkoriyama",
  "codeforkosen",
  "codeforkse",
  "codeforkurume",
  "codeforkusatsu",
  "codeforkuwait",
  "codeforkyana",
  "codeforkyoto",
  "codeforlagos",
  "codeforlancaster",
  "codeforlatam",
  "codeforleipzig",
  "codeforliverpool",
  "codeformadison",
  "codeformali",
  "codeformarin",
  "codeformatsudo",
  "codeformexico",
  "codeformongolia",
  "codeformontevideo",
  "codeformontreal",
  "codeformuenster",
  "codeformumbai",
  "codeformunich",
  "codeformuskogee",
  "codeformx",
  "codeformyanmar",
  "codeformypad",
  "codeformysan",
  "codefornagaland",
  "codefornagareyama",
  "codefornagasaki",
  "codefornamie",
  "codefornanto",
  "codefornepal",
  "codefornewark",
  "codefornewdelhi",
  "codefornewworld",
  "codefornh",
  "codeforniederrhein",
  "codefornigeria",
  "codeforniigata",
  "codefornl",
  "codefornola",
  "codefornomi",
  "codefornow",
  "codefornrv",
  "codefornumazu",
  "codeforoakland",
  "codeforoc",
  "codeforoedo",
  "codeforoita",
  "codeforokc",
  "codeforokinawa",
  "codeforoodua",
  "codeforosnabrueck",
  "codeforottawa",
  "codeforpakistan",
  "codeforpakistan-stuff",
  "codeforpakistanarchive",
  "codeforpalmbeach",
  "codeforparisregion",
  "codeforpb",
  "codeforpdx",
  "codeforpg",
  "codeforphilly",
  "codeforphilly-bot",
  "codeforphilly-zz",
  "codeforpittsburgh",
  "codeforpku",
  "codeforpl",
  "codeforportland",
  "codeforpoznan",
  "codeforpoznanbot",
  "codeforprinceton",
  "codeforrecife",
  "codeforreno",
  "codeforriverside",
  "codeforrkfd",
  "codeforrockford",
  "codeforromania",
  "codeforrtp",
  "codeforruhrgebiet",
  "codeforrussia",
  "codeforrva",
  "codeforsa",
  "codeforsaga",
  "codeforsaigon",
  "codeforsaitama",
  "codeforsanantonio",
  "codeforsanjose",
  "codeforsantabarbara",
  "codeforsantaclarita",
  "codeforsaopaulo",
  "codeforsapporo",
  "codeforsasayamatamba",
  "codeforscv",
  "codeforseattle",
  "codeforseoul",
  "codeforsetagaya",
  "codeforsg",
  "codeforshenlin",
  "codeforshinjuku",
  "codeforshizuoka",
  "codeforsl",
  "codeforsocal",
  "codeforsomalia",
  "codeforspain",
  "codeforsrilanka",
  "codeforstamford",
  "codeforsudan",
  "codeforsummitcounty",
  "codeforsweden",
  "codefortaiwan",
  "codefortallahassee",
  "codefortama-org",
  "codefortamsui",
  "codefortang",
  "codefortelangana",
  "codeforthailand",
  "codeforthecaribbean",
  "codefortibet",
  "codefortoda",
  "codefortokyo",
  "codefortoledo",
  "codefortoshima",
  "codefortoyama",
  "codefortrenggalek",
  "codefortrenton",
  "codefortucson",
  "codefortulsa",
  "codefortune",
  "codeforturkey",
  "codefortuscaloosa",
  "codeforulsan",
  "codeforunitedkingdom",
  "codeforuruguay",
  "codeforvegas",
  "codeforventura",
  "codeforvermont",
  "codeforvilnius",
  "codeforvilnius-ci",
  "codeforwasit",
  "codeforwinstonsalem",
  "codeforwxh",
  "codeforxuwenlong",
  "codeforyokosuka",
 ]