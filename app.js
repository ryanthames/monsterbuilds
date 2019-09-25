'use strict';

const fs = require('fs');

const bloatValues = {
  'SWORD_AND_SHIELD': 1.4,
  'DUAL_BLADES': 1.4,
  'GREATSWORD': 4.8,
  'LONGSWORD': 3.3,
  'HAMMER': 5.2,
  'GUNLANCE': 2.3,
  'LANCE': 2.3,
  'HUNTING_HORN': 4.2,
  'SWITCH_AXE': 3.5,
  'CHARGE_BLADE': 3.6,
  'INSECT_GLAIVE': 3.1,
  'BOW': 1.2,
  'HEAVY_BOWGUN': 1.5,
  'LIGHT_BOWGUN': 1.3
}

const sharpnessValues = {
  'PURPLE': 1.39,
  'WHITE': 1.32,
  'BLUE': 1.2,
  'GREEN': 1.05,
  'YELLOW': 1.0,
  'BROWN': 0.75,
  'RED': 0.5
}

let rawdata = fs.readFileSync('gunlance.json');
let gunlanceBuilds = JSON.parse(rawdata);

console.log(gunlanceBuilds.map(build => calculateEfrForBuild(build)));

function calculateEfrForBuild(build) {
  let trueRaw = getTrueRaw(build.weapon);
  let critMod = getCritMod(build);

  let efr = trueRaw * critMod * sharpnessValues[build.weapon.sharpness];

  return {
    name: build.name,
    efr: efr.toFixed(2)
  }
}

function getTrueRaw(weapon) {
  // TODO add non-ele boost
  return weapon.rawDamage / bloatValues[weapon.weaponType];
}

function getCritMod(build) {
  return ((build.critMod - 1) * build.weapon.affinity < 0 ? 0 : build.weapon.affinity) + 1;
}