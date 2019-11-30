import 'package:epaisa_pos/data/database.dart';
import 'package:epaisa_pos/data/initial/initial.dart';
import 'package:epaisa_pos/data/models/country_dao.dart';

// const countries = [
//   {
//     "flag": 'https://www.countryflags.io/af/flat/64.png',
//     "callingCodes": ['93'],
//     "name": 'Afghanistan',
//     "alpha2Code": 'AF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ax/flat/64.png',
//     "callingCodes": ['358'],
//     "name": 'Aland Islands',
//     "alpha2Code": 'AX',
//   },
//   {
//     "flag": 'https://www.countryflags.io/al/flat/64.png',
//     "callingCodes": ['355'],
//     "name": 'Albania',
//     "alpha2Code": 'AL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/dz/flat/64.png',
//     "callingCodes": ['213'],
//     "name": 'Algeria',
//     "alpha2Code": 'DZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/as/flat/64.png',
//     "callingCodes": ['1684'],
//     "name": 'American Samoa',
//     "alpha2Code": 'AS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ad/flat/64.png',
//     "callingCodes": ['376'],
//     "name": 'Andorra',
//     "alpha2Code": 'AD',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ao/flat/64.png',
//     "callingCodes": ['244'],
//     "name": 'Angola',
//     "alpha2Code": 'AO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ai/flat/64.png',
//     "callingCodes": ['1264'],
//     "name": 'Anguilla',
//     "alpha2Code": 'AI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/aq/flat/64.png',
//     "callingCodes": ['672'],
//     "name": 'Antarctica',
//     "alpha2Code": 'AQ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ag/flat/64.png',
//     "callingCodes": ['1268'],
//     "name": 'Antigua and Barbuda',
//     "alpha2Code": 'AG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ar/flat/64.png',
//     "callingCodes": ['54'],
//     "name": 'Argentina',
//     "alpha2Code": 'AR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/am/flat/64.png',
//     "callingCodes": ['374'],
//     "name": 'Armenia',
//     "alpha2Code": 'AM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/aw/flat/64.png',
//     "callingCodes": ['297'],
//     "name": 'Aruba',
//     "alpha2Code": 'AW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/au/flat/64.png',
//     "callingCodes": ['61'],
//     "name": 'Australia',
//     "alpha2Code": 'AU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/at/flat/64.png',
//     "callingCodes": ['43'],
//     "name": 'Austria',
//     "alpha2Code": 'AT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/az/flat/64.png',
//     "callingCodes": ['994'],
//     "name": 'Azerbaijan',
//     "alpha2Code": 'AZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bs/flat/64.png',
//     "callingCodes": ['1242'],
//     "name": 'Bahamas',
//     "alpha2Code": 'BS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bh/flat/64.png',
//     "callingCodes": ['973'],
//     "name": 'Bahrain',
//     "alpha2Code": 'BH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bd/flat/64.png',
//     "callingCodes": ['880'],
//     "name": 'Bangladesh',
//     "alpha2Code": 'BD',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bb/flat/64.png',
//     "callingCodes": ['1246'],
//     "name": 'Barbados',
//     "alpha2Code": 'BB',
//   },
//   {
//     "flag": 'https://www.countryflags.io/by/flat/64.png',
//     "callingCodes": ['375'],
//     "name": 'Belarus',
//     "alpha2Code": 'BY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/be/flat/64.png',
//     "callingCodes": ['32'],
//     "name": 'Belgium',
//     "alpha2Code": 'BE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bz/flat/64.png',
//     "callingCodes": ['501'],
//     "name": 'Belize',
//     "alpha2Code": 'BZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bj/flat/64.png',
//     "callingCodes": ['229'],
//     "name": 'Benin',
//     "alpha2Code": 'BJ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bm/flat/64.png',
//     "callingCodes": ['1441'],
//     "name": 'Bermuda',
//     "alpha2Code": 'BM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bt/flat/64.png',
//     "callingCodes": ['975'],
//     "name": 'Bhutan',
//     "alpha2Code": 'BT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bo/flat/64.png',
//     "callingCodes": ['591'],
//     "name": 'Bolivia (Plurinational State of)',
//     "alpha2Code": 'BO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bq/flat/64.png',
//     "callingCodes": ['5997'],
//     "name": 'Bonaire, Sint Eustatius and Saba',
//     "alpha2Code": 'BQ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ba/flat/64.png',
//     "callingCodes": ['387'],
//     "name": 'Bosnia and Herzegovina',
//     "alpha2Code": 'BA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bw/flat/64.png',
//     "callingCodes": ['267'],
//     "name": 'Botswana',
//     "alpha2Code": 'BW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/br/flat/64.png',
//     "callingCodes": ['55'],
//     "name": 'Brazil',
//     "alpha2Code": 'BR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/io/flat/64.png',
//     "callingCodes": ['246'],
//     "name": 'British Indian Ocean Territory',
//     "alpha2Code": 'IO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bn/flat/64.png',
//     "callingCodes": ['673'],
//     "name": 'Brunei Darussalam',
//     "alpha2Code": 'BN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bg/flat/64.png',
//     "callingCodes": ['359'],
//     "name": 'Bulgaria',
//     "alpha2Code": 'BG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bf/flat/64.png',
//     "callingCodes": ['226'],
//     "name": 'Burkina Faso',
//     "alpha2Code": 'BF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bi/flat/64.png',
//     "callingCodes": ['257'],
//     "name": 'Burundi',
//     "alpha2Code": 'BI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cv/flat/64.png',
//     "callingCodes": ['238'],
//     "name": 'Cabo Verde',
//     "alpha2Code": 'CV',
//   },
//   {
//     "flag": 'https://www.countryflags.io/kh/flat/64.png',
//     "callingCodes": ['855'],
//     "name": 'Cambodia',
//     "alpha2Code": 'KH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cm/flat/64.png',
//     "callingCodes": ['237'],
//     "name": 'Cameroon',
//     "alpha2Code": 'CM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ca/flat/64.png',
//     "callingCodes": ['1'],
//     "name": 'Canada',
//     "alpha2Code": 'CA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ky/flat/64.png',
//     "callingCodes": ['1345'],
//     "name": 'Cayman Islands',
//     "alpha2Code": 'KY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cf/flat/64.png',
//     "callingCodes": ['236'],
//     "name": 'Central African Republic',
//     "alpha2Code": 'CF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/td/flat/64.png',
//     "callingCodes": ['235'],
//     "name": 'Chad',
//     "alpha2Code": 'TD',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cl/flat/64.png',
//     "callingCodes": ['56'],
//     "name": 'Chile',
//     "alpha2Code": 'CL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cn/flat/64.png',
//     "callingCodes": ['86'],
//     "name": 'China',
//     "alpha2Code": 'CN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cx/flat/64.png',
//     "callingCodes": ['61'],
//     "name": 'Christmas Island',
//     "alpha2Code": 'CX',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cc/flat/64.png',
//     "callingCodes": ['61'],
//     "name": 'Cocos (Keeling) Islands',
//     "alpha2Code": 'CC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/co/flat/64.png',
//     "callingCodes": ['57'],
//     "name": 'Colombia',
//     "alpha2Code": 'CO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/km/flat/64.png',
//     "callingCodes": ['269'],
//     "name": 'Comoros',
//     "alpha2Code": 'KM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cg/flat/64.png',
//     "callingCodes": ['242'],
//     "name": 'Congo',
//     "alpha2Code": 'CG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cd/flat/64.png',
//     "callingCodes": ['243'],
//     "name": 'Congo (Democratic Republic of the)',
//     "alpha2Code": 'CD',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ck/flat/64.png',
//     "callingCodes": ['682'],
//     "name": 'Cook Islands',
//     "alpha2Code": 'CK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cr/flat/64.png',
//     "callingCodes": ['506'],
//     "name": 'Costa Rica',
//     "alpha2Code": 'CR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ci/flat/64.png',
//     "callingCodes": ['225'],
//     "name": "Côte d'Ivoire",
//     "alpha2Code": 'CI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/hr/flat/64.png',
//     "callingCodes": ['385'],
//     "name": 'Croatia',
//     "alpha2Code": 'HR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cu/flat/64.png',
//     "callingCodes": ['53'],
//     "name": 'Cuba',
//     "alpha2Code": 'CU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cw/flat/64.png',
//     "callingCodes": ['599'],
//     "name": 'Curaçao',
//     "alpha2Code": 'CW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cy/flat/64.png',
//     "callingCodes": ['357'],
//     "name": 'Cyprus',
//     "alpha2Code": 'CY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/cz/flat/64.png',
//     "callingCodes": ['420'],
//     "name": 'Czech Republic',
//     "alpha2Code": 'CZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/dk/flat/64.png',
//     "callingCodes": ['45'],
//     "name": 'Denmark',
//     "alpha2Code": 'DK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/dj/flat/64.png',
//     "callingCodes": ['253'],
//     "name": 'Djibouti',
//     "alpha2Code": 'DJ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/dm/flat/64.png',
//     "callingCodes": ['1767'],
//     "name": 'Dominica',
//     "alpha2Code": 'DM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/do/flat/64.png',
//     "callingCodes": ['1809', '1829', '1849'],
//     "name": 'Dominican Republic',
//     "alpha2Code": 'DO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ec/flat/64.png',
//     "callingCodes": ['593'],
//     "name": 'Ecuador',
//     "alpha2Code": 'EC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/eg/flat/64.png',
//     "callingCodes": ['20'],
//     "name": 'Egypt',
//     "alpha2Code": 'EG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sv/flat/64.png',
//     "callingCodes": ['503'],
//     "name": 'El Salvador',
//     "alpha2Code": 'SV',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gq/flat/64.png',
//     "callingCodes": ['240'],
//     "name": 'Equatorial Guinea',
//     "alpha2Code": 'GQ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/er/flat/64.png',
//     "callingCodes": ['291'],
//     "name": 'Eritrea',
//     "alpha2Code": 'ER',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ee/flat/64.png',
//     "callingCodes": ['372'],
//     "name": 'Estonia',
//     "alpha2Code": 'EE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/et/flat/64.png',
//     "callingCodes": ['251'],
//     "name": 'Ethiopia',
//     "alpha2Code": 'ET',
//   },
//   {
//     "flag": 'https://www.countryflags.io/fk/flat/64.png',
//     "callingCodes": ['500'],
//     "name": 'Falkland Islands (Malvinas)',
//     "alpha2Code": 'FK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/fo/flat/64.png',
//     "callingCodes": ['298'],
//     "name": 'Faroe Islands',
//     "alpha2Code": 'FO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/fj/flat/64.png',
//     "callingCodes": ['679'],
//     "name": 'Fiji',
//     "alpha2Code": 'FJ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/fi/flat/64.png',
//     "callingCodes": ['358'],
//     "name": 'Finland',
//     "alpha2Code": 'FI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/fr/flat/64.png',
//     "callingCodes": ['33'],
//     "name": 'France',
//     "alpha2Code": 'FR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gf/flat/64.png',
//     "callingCodes": ['594'],
//     "name": 'French Guiana',
//     "alpha2Code": 'GF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pf/flat/64.png',
//     "callingCodes": ['689'],
//     "name": 'French Polynesia',
//     "alpha2Code": 'PF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ga/flat/64.png',
//     "callingCodes": ['241'],
//     "name": 'Gabon',
//     "alpha2Code": 'GA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gm/flat/64.png',
//     "callingCodes": ['220'],
//     "name": 'Gambia',
//     "alpha2Code": 'GM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ge/flat/64.png',
//     "callingCodes": ['995'],
//     "name": 'Georgia',
//     "alpha2Code": 'GE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/de/flat/64.png',
//     "callingCodes": ['49'],
//     "name": 'Germany',
//     "alpha2Code": 'DE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gh/flat/64.png',
//     "callingCodes": ['233'],
//     "name": 'Ghana',
//     "alpha2Code": 'GH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gi/flat/64.png',
//     "callingCodes": ['350'],
//     "name": 'Gibraltar',
//     "alpha2Code": 'GI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gr/flat/64.png',
//     "callingCodes": ['30'],
//     "name": 'Greece',
//     "alpha2Code": 'GR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gl/flat/64.png',
//     "callingCodes": ['299'],
//     "name": 'Greenland',
//     "alpha2Code": 'GL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gd/flat/64.png',
//     "callingCodes": ['1473'],
//     "name": 'Grenada',
//     "alpha2Code": 'GD',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gp/flat/64.png',
//     "callingCodes": ['590'],
//     "name": 'Guadeloupe',
//     "alpha2Code": 'GP',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gu/flat/64.png',
//     "callingCodes": ['1671'],
//     "name": 'Guam',
//     "alpha2Code": 'GU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gt/flat/64.png',
//     "callingCodes": ['502'],
//     "name": 'Guatemala',
//     "alpha2Code": 'GT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gg/flat/64.png',
//     "callingCodes": ['44'],
//     "name": 'Guernsey',
//     "alpha2Code": 'GG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gn/flat/64.png',
//     "callingCodes": ['224'],
//     "name": 'Guinea',
//     "alpha2Code": 'GQ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gw/flat/64.png',
//     "callingCodes": ['245'],
//     "name": 'Guinea-Bissau',
//     "alpha2Code": 'GW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gy/flat/64.png',
//     "callingCodes": ['592'],
//     "name": 'Guyana',
//     "alpha2Code": 'GY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ht/flat/64.png',
//     "callingCodes": ['509'],
//     "name": 'Haiti',
//     "alpha2Code": 'HT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/va/flat/64.png',
//     "callingCodes": ['379'],
//     "name": 'Holy See',
//     "alpha2Code": 'VA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/hn/flat/64.png',
//     "callingCodes": ['504'],
//     "name": 'Honduras',
//     "alpha2Code": 'HN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/hk/flat/64.png',
//     "callingCodes": ['852'],
//     "name": 'Hong Kong',
//     "alpha2Code": 'HK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/hu/flat/64.png',
//     "callingCodes": ['36'],
//     "name": 'Hungary',
//     "alpha2Code": 'HU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/is/flat/64.png',
//     "callingCodes": ['354'],
//     "name": 'Iceland',
//     "alpha2Code": 'IS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/in/flat/64.png',
//     "callingCodes": ['91'],
//     "name": 'India',
//     "alpha2Code": 'IN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/id/flat/64.png',
//     "callingCodes": ['62'],
//     "name": 'Indonesia',
//     "alpha2Code": 'ID',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ir/flat/64.png',
//     "callingCodes": ['98'],
//     "name": 'Iran (Islamic Republic of)',
//     "alpha2Code": 'IR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/iq/flat/64.png',
//     "callingCodes": ['964'],
//     "name": 'Iraq',
//     "alpha2Code": 'IQ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ie/flat/64.png',
//     "callingCodes": ['353'],
//     "name": 'Ireland',
//     "alpha2Code": 'IE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/im/flat/64.png',
//     "callingCodes": ['44'],
//     "name": 'Isle of Man',
//     "alpha2Code": 'IM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/il/flat/64.png',
//     "callingCodes": ['972'],
//     "name": 'Israel',
//     "alpha2Code": 'IL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/it/flat/64.png',
//     "callingCodes": ['39'],
//     "name": 'Italy',
//     "alpha2Code": 'IT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/jm/flat/64.png',
//     "callingCodes": ['1876'],
//     "name": 'Jamaica',
//     "alpha2Code": 'JM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/jp/flat/64.png',
//     "callingCodes": ['81'],
//     "name": 'Japan',
//     "alpha2Code": 'JP',
//   },
//   {
//     "flag": 'https://www.countryflags.io/je/flat/64.png',
//     "callingCodes": ['44'],
//     "name": 'Jersey',
//     "alpha2Code": 'JE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/jo/flat/64.png',
//     "callingCodes": ['962'],
//     "name": 'Jordan',
//     "alpha2Code": 'JO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/kz/flat/64.png',
//     "callingCodes": ['76', '77'],
//     "name": 'Kazakhstan',
//     "alpha2Code": 'KZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ke/flat/64.png',
//     "callingCodes": ['254'],
//     "name": 'Kenya',
//     "alpha2Code": 'KE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ki/flat/64.png',
//     "callingCodes": ['686'],
//     "name": 'Kiribati',
//     "alpha2Code": 'KI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/kp/flat/64.png',
//     "callingCodes": ['850'],
//     "name": "Korea (Democratic People's Republic of)",
//     "alpha2Code": 'KP',
//   },
//   {
//     "flag": 'https://www.countryflags.io/kr/flat/64.png',
//     "callingCodes": ['82'],
//     "name": 'Korea (Republic of)',
//     "alpha2Code": 'KR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/kw/flat/64.png',
//     "callingCodes": ['965'],
//     "name": 'Kuwait',
//     "alpha2Code": 'KW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/kg/flat/64.png',
//     "callingCodes": ['996'],
//     "name": 'Kyrgyzstan',
//     "alpha2Code": 'KG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/la/flat/64.png',
//     "callingCodes": ['856'],
//     "name": "Lao People's Democratic Republic",
//     "alpha2Code": 'LA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/lv/flat/64.png',
//     "callingCodes": ['371'],
//     "name": 'Latvia',
//     "alpha2Code": 'LV',
//   },
//   {
//     "flag": 'https://www.countryflags.io/lb/flat/64.png',
//     "callingCodes": ['961'],
//     "name": 'Lebanon',
//     "alpha2Code": 'LB',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ls/flat/64.png',
//     "callingCodes": ['266'],
//     "name": 'Lesotho',
//     "alpha2Code": 'LS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/lr/flat/64.png',
//     "callingCodes": ['231'],
//     "name": 'Liberia',
//     "alpha2Code": 'LR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ly/flat/64.png',
//     "callingCodes": ['218'],
//     "name": 'Libya',
//     "alpha2Code": 'LY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/li/flat/64.png',
//     "callingCodes": ['423'],
//     "name": 'Liechtenstein',
//     "alpha2Code": 'LI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/lt/flat/64.png',
//     "callingCodes": ['370'],
//     "name": 'Lithuania',
//     "alpha2Code": 'LT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/lu/flat/64.png',
//     "callingCodes": ['352'],
//     "name": 'Luxembourg',
//     "alpha2Code": 'LU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mo/flat/64.png',
//     "callingCodes": ['853'],
//     "name": 'Macao',
//     "alpha2Code": 'MO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mk/flat/64.png',
//     "callingCodes": ['389'],
//     "name": 'Macedonia (the former Yugoslav Republic of)',
//     "alpha2Code": 'MK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mg/flat/64.png',
//     "callingCodes": ['261'],
//     "name": 'Madagascar',
//     "alpha2Code": 'MG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mw/flat/64.png',
//     "callingCodes": ['265'],
//     "name": 'Malawi',
//     "alpha2Code": 'MW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/my/flat/64.png',
//     "callingCodes": ['60'],
//     "name": 'Malaysia',
//     "alpha2Code": 'MY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mv/flat/64.png',
//     "callingCodes": ['960'],
//     "name": 'Maldives',
//     "alpha2Code": 'MV',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ml/flat/64.png',
//     "callingCodes": ['223'],
//     "name": 'Mali',
//     "alpha2Code": 'ML',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mt/flat/64.png',
//     "callingCodes": ['356'],
//     "name": 'Malta',
//     "alpha2Code": 'MT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mh/flat/64.png',
//     "callingCodes": ['692'],
//     "name": 'Marshall Islands',
//     "alpha2Code": 'MH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mq/flat/64.png',
//     "callingCodes": ['596'],
//     "name": 'Martinique',
//     "alpha2Code": 'MQ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mr/flat/64.png',
//     "callingCodes": ['222'],
//     "name": 'Mauritania',
//     "alpha2Code": 'MR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mu/flat/64.png',
//     "callingCodes": ['230'],
//     "name": 'Mauritius',
//     "alpha2Code": 'MU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/yt/flat/64.png',
//     "callingCodes": ['262'],
//     "name": 'Mayotte',
//     "alpha2Code": 'YT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mx/flat/64.png',
//     "callingCodes": ['52'],
//     "name": 'Mexico',
//     "alpha2Code": 'MX',
//   },
//   {
//     "flag": 'https://www.countryflags.io/fm/flat/64.png',
//     "callingCodes": ['691'],
//     "name": 'Micronesia (Federated States of)',
//     "alpha2Code": 'FM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/md/flat/64.png',
//     "callingCodes": ['373'],
//     "name": 'Moldova (Republic of)',
//     "alpha2Code": 'MD',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mc/flat/64.png',
//     "callingCodes": ['377'],
//     "name": 'Monaco',
//     "alpha2Code": 'MC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mn/flat/64.png',
//     "callingCodes": ['976'],
//     "name": 'Mongolia',
//     "alpha2Code": 'MN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/me/flat/64.png',
//     "callingCodes": ['382'],
//     "name": 'Montenegro',
//     "alpha2Code": 'ME',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ms/flat/64.png',
//     "callingCodes": ['1664'],
//     "name": 'Montserrat',
//     "alpha2Code": 'MS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ma/flat/64.png',
//     "callingCodes": ['212'],
//     "name": 'Morocco',
//     "alpha2Code": 'MA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mz/flat/64.png',
//     "callingCodes": ['258'],
//     "name": 'Mozambique',
//     "alpha2Code": 'MZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mm/flat/64.png',
//     "callingCodes": ['95'],
//     "name": 'Myanmar',
//     "alpha2Code": 'MM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/na/flat/64.png',
//     "callingCodes": ['264'],
//     "name": 'Namibia',
//     "alpha2Code": 'NA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/nr/flat/64.png',
//     "callingCodes": ['674'],
//     "name": 'Nauru',
//     "alpha2Code": 'NR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/np/flat/64.png',
//     "callingCodes": ['977'],
//     "name": 'Nepal',
//     "alpha2Code": 'NP',
//   },
//   {
//     "flag": 'https://www.countryflags.io/nl/flat/64.png',
//     "callingCodes": ['31'],
//     "name": 'Netherlands',
//     "alpha2Code": 'NL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/nc/flat/64.png',
//     "callingCodes": ['687'],
//     "name": 'New Caledonia',
//     "alpha2Code": 'NC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/nz/flat/64.png',
//     "callingCodes": ['64'],
//     "name": 'New Zealand',
//     "alpha2Code": 'NZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ni/flat/64.png',
//     "callingCodes": ['505'],
//     "name": 'Nicaragua',
//     "alpha2Code": 'NI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ne/flat/64.png',
//     "callingCodes": ['227'],
//     "name": 'Niger',
//     "alpha2Code": 'NE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ng/flat/64.png',
//     "callingCodes": ['234'],
//     "name": 'Nigeria',
//     "alpha2Code": 'NG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/nu/flat/64.png',
//     "callingCodes": ['683'],
//     "name": 'Niue',
//     "alpha2Code": 'NU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/nf/flat/64.png',
//     "callingCodes": ['672'],
//     "name": 'Norfolk Island',
//     "alpha2Code": 'NF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mp/flat/64.png',
//     "callingCodes": ['1670'],
//     "name": 'Northern Mariana Islands',
//     "alpha2Code": 'MP',
//   },
//   {
//     "flag": 'https://www.countryflags.io/no/flat/64.png',
//     "callingCodes": ['47'],
//     "name": 'Norway',
//     "alpha2Code": 'NO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/om/flat/64.png',
//     "callingCodes": ['968'],
//     "name": 'Oman',
//     "alpha2Code": 'OM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pk/flat/64.png',
//     "callingCodes": ['92'],
//     "name": 'Pakistan',
//     "alpha2Code": 'PK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pw/flat/64.png',
//     "callingCodes": ['680'],
//     "name": 'Palau',
//     "alpha2Code": 'PW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ps/flat/64.png',
//     "callingCodes": ['970'],
//     "name": 'Palestine, State of',
//     "alpha2Code": 'PS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pa/flat/64.png',
//     "callingCodes": ['507'],
//     "name": 'Panama',
//     "alpha2Code": 'PA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pg/flat/64.png',
//     "callingCodes": ['675'],
//     "name": 'Papua New Guinea',
//     "alpha2Code": 'PG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/py/flat/64.png',
//     "callingCodes": ['595'],
//     "name": 'Paraguay',
//     "alpha2Code": 'PY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pe/flat/64.png',
//     "callingCodes": ['51'],
//     "name": 'Peru',
//     "alpha2Code": 'PE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ph/flat/64.png',
//     "callingCodes": ['63'],
//     "name": 'Philippines',
//     "alpha2Code": 'PH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pn/flat/64.png',
//     "callingCodes": ['64'],
//     "name": 'Pitcairn',
//     "alpha2Code": 'PN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pl/flat/64.png',
//     "callingCodes": ['48'],
//     "name": 'Poland',
//     "alpha2Code": 'PL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pt/flat/64.png',
//     "callingCodes": ['351'],
//     "name": 'Portugal',
//     "alpha2Code": 'PT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pr/flat/64.png',
//     "callingCodes": ['1787', '1939'],
//     "name": 'Puerto Rico',
//     "alpha2Code": 'PR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/qa/flat/64.png',
//     "callingCodes": ['974'],
//     "name": 'Qatar',
//     "alpha2Code": 'QA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/xk/flat/64.png',
//     "callingCodes": ['383'],
//     "name": 'Republic of Kosovo',
//     "alpha2Code": 'XK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/re/flat/64.png',
//     "callingCodes": ['262'],
//     "name": 'Réunion',
//     "alpha2Code": 'RE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ro/flat/64.png',
//     "callingCodes": ['40'],
//     "name": 'Romania',
//     "alpha2Code": 'RO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ru/flat/64.png',
//     "callingCodes": ['7'],
//     "name": 'Russian Federation',
//     "alpha2Code": 'RU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/rw/flat/64.png',
//     "callingCodes": ['250'],
//     "name": 'Rwanda',
//     "alpha2Code": 'RW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/bl/flat/64.png',
//     "callingCodes": ['590'],
//     "name": 'Saint Barthélemy',
//     "alpha2Code": 'BL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sh/flat/64.png',
//     "callingCodes": ['290'],
//     "name": 'Saint Helena, Ascension and Tristan da Cunha',
//     "alpha2Code": 'SH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/kn/flat/64.png',
//     "callingCodes": ['1869'],
//     "name": 'Saint Kitts and Nevis',
//     "alpha2Code": 'KN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/lc/flat/64.png',
//     "callingCodes": ['1758'],
//     "name": 'Saint Lucia',
//     "alpha2Code": 'LC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/mf/flat/64.png',
//     "callingCodes": ['590'],
//     "name": 'Saint Martin (French part)',
//     "alpha2Code": 'MF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/pm/flat/64.png',
//     "callingCodes": ['508'],
//     "name": 'Saint Pierre and Miquelon',
//     "alpha2Code": 'PM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/vc/flat/64.png',
//     "callingCodes": ['1784'],
//     "name": 'Saint Vincent and the Grenadines',
//     "alpha2Code": 'VC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ws/flat/64.png',
//     "callingCodes": ['685'],
//     "name": 'Samoa',
//     "alpha2Code": 'AS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sm/flat/64.png',
//     "callingCodes": ['378'],
//     "name": 'San Marino',
//     "alpha2Code": 'SM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/st/flat/64.png',
//     "callingCodes": ['239'],
//     "name": 'Sao Tome and Principe',
//     "alpha2Code": 'ST',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sa/flat/64.png',
//     "callingCodes": ['966'],
//     "name": 'Saudi Arabia',
//     "alpha2Code": 'SA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sn/flat/64.png',
//     "callingCodes": ['221'],
//     "name": 'Senegal',
//     "alpha2Code": 'SN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/rs/flat/64.png',
//     "callingCodes": ['381'],
//     "name": 'Serbia',
//     "alpha2Code": 'RS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sc/flat/64.png',
//     "callingCodes": ['248'],
//     "name": 'Seychelles',
//     "alpha2Code": 'SC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sl/flat/64.png',
//     "callingCodes": ['232'],
//     "name": 'Sierra Leone',
//     "alpha2Code": 'SL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sg/flat/64.png',
//     "callingCodes": ['65'],
//     "name": 'Singapore',
//     "alpha2Code": 'SG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sx/flat/64.png',
//     "callingCodes": ['1721'],
//     "name": 'Sint Maarten (Dutch part)',
//     "alpha2Code": 'SX',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sk/flat/64.png',
//     "callingCodes": ['421'],
//     "name": 'Slovakia',
//     "alpha2Code": 'SK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/si/flat/64.png',
//     "callingCodes": ['386'],
//     "name": 'Slovenia',
//     "alpha2Code": 'SI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sb/flat/64.png',
//     "callingCodes": ['677'],
//     "name": 'Solomon Islands',
//     "alpha2Code": 'SB',
//   },
//   {
//     "flag": 'https://www.countryflags.io/so/flat/64.png',
//     "callingCodes": ['252'],
//     "name": 'Somalia',
//     "alpha2Code": 'SO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/za/flat/64.png',
//     "callingCodes": ['27'],
//     "name": 'South Africa',
//     "alpha2Code": 'ZA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gs/flat/64.png',
//     "callingCodes": ['500'],
//     "name": 'South Georgia and the South Sandwich Islands',
//     "alpha2Code": 'GS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ss/flat/64.png',
//     "callingCodes": ['211'],
//     "name": 'South Sudan',
//     "alpha2Code": 'SS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/es/flat/64.png',
//     "callingCodes": ['34'],
//     "name": 'Spain',
//     "alpha2Code": 'ES',
//   },
//   {
//     "flag": 'https://www.countryflags.io/lk/flat/64.png',
//     "callingCodes": ['94'],
//     "name": 'Sri Lanka',
//     "alpha2Code": 'LK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sd/flat/64.png',
//     "callingCodes": ['249'],
//     "name": 'Sudan',
//     "alpha2Code": 'SS',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sr/flat/64.png',
//     "callingCodes": ['597'],
//     "name": 'Suriname',
//     "alpha2Code": 'SR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sj/flat/64.png',
//     "callingCodes": ['4779'],
//     "name": 'Svalbard and Jan Mayen',
//     "alpha2Code": 'SJ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sz/flat/64.png',
//     "callingCodes": ['268'],
//     "name": 'Swaziland',
//     "alpha2Code": 'SZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/se/flat/64.png',
//     "callingCodes": ['46'],
//     "name": 'Sweden',
//     "alpha2Code": 'SE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ch/flat/64.png',
//     "callingCodes": ['41'],
//     "name": 'Switzerland',
//     "alpha2Code": 'CH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/sy/flat/64.png',
//     "callingCodes": ['963'],
//     "name": 'Syrian Arab Republic',
//     "alpha2Code": 'SY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tw/flat/64.png',
//     "callingCodes": ['886'],
//     "name": 'Taiwan',
//     "alpha2Code": 'TW',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tj/flat/64.png',
//     "callingCodes": ['992'],
//     "name": 'Tajikistan',
//     "alpha2Code": 'TJ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tz/flat/64.png',
//     "callingCodes": ['255'],
//     "name": 'Tanzania, United Republic of',
//     "alpha2Code": 'TZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/th/flat/64.png',
//     "callingCodes": ['66'],
//     "name": 'Thailand',
//     "alpha2Code": 'TH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tl/flat/64.png',
//     "callingCodes": ['670'],
//     "name": 'Timor-Leste',
//     "alpha2Code": 'TL',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tg/flat/64.png',
//     "callingCodes": ['228'],
//     "name": 'Togo',
//     "alpha2Code": 'TG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tk/flat/64.png',
//     "callingCodes": ['690'],
//     "name": 'Tokelau',
//     "alpha2Code": 'TK',
//   },
//   {
//     "flag": 'https://www.countryflags.io/to/flat/64.png',
//     "callingCodes": ['676'],
//     "name": 'Tonga',
//     "alpha2Code": 'TO',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tt/flat/64.png',
//     "callingCodes": ['1868'],
//     "name": 'Trinidad and Tobago',
//     "alpha2Code": 'TT',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tn/flat/64.png',
//     "callingCodes": ['216'],
//     "name": 'Tunisia',
//     "alpha2Code": 'TN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tr/flat/64.png',
//     "callingCodes": ['90'],
//     "name": 'Turkey',
//     "alpha2Code": 'TR',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tm/flat/64.png',
//     "callingCodes": ['993'],
//     "name": 'Turkmenistan',
//     "alpha2Code": 'TM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tc/flat/64.png',
//     "callingCodes": ['1649'],
//     "name": 'Turks and Caicos Islands',
//     "alpha2Code": 'TC',
//   },
//   {
//     "flag": 'https://www.countryflags.io/tv/flat/64.png',
//     "callingCodes": ['688'],
//     "name": 'Tuvalu',
//     "alpha2Code": 'TV',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ug/flat/64.png',
//     "callingCodes": ['256'],
//     "name": 'Uganda',
//     "alpha2Code": 'UG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ua/flat/64.png',
//     "callingCodes": ['380'],
//     "name": 'Ukraine',
//     "alpha2Code": 'UA',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ae/flat/64.png',
//     "callingCodes": ['971'],
//     "name": 'United Arab Emirates',
//     "alpha2Code": 'AE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/gb/flat/64.png',
//     "callingCodes": ['44'],
//     "name": 'United Kingdom of Great Britain and Northern Ireland',
//     "alpha2Code": 'GB',
//   },
//   {
//     "flag": 'https://www.countryflags.io/us/flat/64.png',
//     "callingCodes": ['1'],
//     "name": 'United States of America',
//     "alpha2Code": 'US',
//   },
//   {
//     "flag": 'https://www.countryflags.io/uy/flat/64.png',
//     "callingCodes": ['598'],
//     "name": 'Uruguay',
//     "alpha2Code": 'UY',
//   },
//   {
//     "flag": 'https://www.countryflags.io/uz/flat/64.png',
//     "callingCodes": ['998'],
//     "name": 'Uzbekistan',
//     "alpha2Code": 'UZ',
//   },
//   {
//     "flag": 'https://www.countryflags.io/vu/flat/64.png',
//     "callingCodes": ['678'],
//     "name": 'Vanuatu',
//     "alpha2Code": 'VU',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ve/flat/64.png',
//     "callingCodes": ['58'],
//     "name": 'Venezuela (Bolivarian Republic of)',
//     "alpha2Code": 'VE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/vn/flat/64.png',
//     "callingCodes": ['84'],
//     "name": 'Viet Nam',
//     "alpha2Code": 'VN',
//   },
//   {
//     "flag": 'https://www.countryflags.io/vg/flat/64.png',
//     "callingCodes": ['1284'],
//     "name": 'Virgin Islands (British)',
//     "alpha2Code": 'VG',
//   },
//   {
//     "flag": 'https://www.countryflags.io/vi/flat/64.png',
//     "callingCodes": ['1 340'],
//     "name": 'Virgin Islands (U.S.)',
//     "alpha2Code": 'VI',
//   },
//   {
//     "flag": 'https://www.countryflags.io/wf/flat/64.png',
//     "callingCodes": ['681'],
//     "name": 'Wallis and Futuna',
//     "alpha2Code": 'WF',
//   },
//   {
//     "flag": 'https://www.countryflags.io/eh/flat/64.png',
//     "callingCodes": ['212'],
//     "name": 'Western Sahara',
//     "alpha2Code": 'EH',
//   },
//   {
//     "flag": 'https://www.countryflags.io/ye/flat/64.png',
//     "callingCodes": ['967'],
//     "name": 'Yemen',
//     "alpha2Code": 'YE',
//   },
//   {
//     "flag": 'https://www.countryflags.io/zm/flat/64.png',
//     "callingCodes": ['260'],
//     "name": 'Zambia',
//     "alpha2Code": 'ZM',
//   },
//   {
//     "flag": 'https://www.countryflags.io/zw/flat/64.png',
//     "callingCodes": ['263'],
//     "name": 'Zimbabwe',
//     "alpha2Code": 'ZW',
//   },
// ];

class CountryObj {
  String flag;
  List<String> callingCodes;
  String name;
  String alpha2Code;

  CountryObj({this.flag, this.callingCodes, this.name, this.alpha2Code});

  CountryObj clone() {
    return new CountryObj(
        flag: flag,
        callingCodes: callingCodes,
        name: name,
        alpha2Code: alpha2Code);
  }
}

var abc = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",
  "#"
];

class CountryList {
  List<CountryObj> list = new List<CountryObj>();
  String key;
  CountryList({this.list, this.key});
  List<CountryObj> filtered(query) {
    List<CountryObj> newlist = new List<CountryObj>();
    for (var i = 0; i < list.length; i++) {
      if (list[i].name.toUpperCase().contains(query.toUpperCase())) {
        newlist.add(list[i]);
      }
    }
    return newlist;
  }
}

Future<List<CountryList>> structCountries() async {
  final countries = await CountryDao(AppDatabase()).getAll();
  List<CountryList> res = new List<CountryList>();
  for (var i = 0; i < abc.length; i++) {
    //res.add
    List<CountryObj> ptemp = new List<CountryObj>();
    var plist =
        countries.where((f) => f.name[0].toUpperCase() == abc[i]).toList();

    for (var j = 0; j < plist.length; j++) {
      ptemp.add(
        new CountryObj(
          alpha2Code: plist[j].alpha2Code,
          callingCodes: [plist[j].dialCode.toString()],
          flag: "",
          name: plist[j].name,
        ),
      );
    }
    CountryList item = new CountryList(key: abc[i], list: ptemp);

    res.add(item);
  }
  return res;
}

Future<CountryData> getWithCode(int code) async {
  print("FIRST");
  CountryDao cdao = new CountryDao(db);
  var countries;
  try {
    countries = await cdao.getCode(code);
  } catch (e) {
    print(e);
  }

  print("FIRST ${countries.toJsonString()}");
  return countries;
}
// var countriesStruct = structCountries();

filterQuery(query, src) {
  //print('2${countriesStruct.length}');
  List<CountryList> resfilt = new List<CountryList>();

  for (var i = 0; i < src.length; i++) {
    print(i);

    print("second2");
    CountryList newContainer =
        new CountryList(key: src[i].key, list: src[i].filtered(query));
    print("second3");
    resfilt.add(newContainer);
  }
  //print(resfilt);
  return resfilt;
}
