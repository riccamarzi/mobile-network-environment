from pymongo import MongoClient
from copy import deepcopy

mongoUri = "mongodb://10.1.1.253"

connection = MongoClient(mongoUri)
client = connection["open5gs"]
sub_collection = client["subscribers"]

profile_default = {
            'imsi': '',
            'subscribed_rau_rau_timer': 12,
            'network_access_mode': 0,
            'subscriber_status': 0,
            'access_restriction_data': 32,
            'slice': [
                {
                    'sst': 1,
                    'default_indicator': True,
                    'session': [
                        {
                            'name': 'internet',
                            'type': 1,
                            'pcc_rule': [],
                            'ambr': {
                                'uplink': {
                                    'value': 1,
                                    'unit': 3
                                },
                                'downlink': {
                                    'value': 1,
                                    'unit':3
                                }
                            },
                            'qos': {
                                'index': 9,
                                'arp': {
                                    'priority_level': 8,
                                    'pre_emption_capability': 1,
                                    'pre_emption_vulnerability': 1
                                }
                            }
                        },
                        {
                            'name': 'ims',
                            'type': 1,
                            'pcc_rule': [
                                {
                                    'qos': {
                                        'index': 1,
                                        'gbr': {
                                            'uplink': {
                                                'unit': 1    
                                            },
                                            'downlink': {
                                                'unit': 1    
                                            }
                                        },
                                        'mbr': {
                                            'uplink': {
                                                'unit': 1    
                                            },
                                            'downlink': {
                                                'unit': 1    
                                            }
                                        },
                                        'arp': {
                                            'priority_level': 2,
                                            'pre_emption_capability': 2,
                                            'pre_emption_vulnerability': 2
                                        }
                                    },
                                    'flow': []
                                },
                                {
                                    'qos': {
                                        'index': 2,
                                        'gbr': {
                                            'uplink': {
                                                'unit': 1    
                                            },
                                            'downlink': {
                                                'unit': 1    
                                            }
                                        },
                                        'mbr': {
                                            'uplink': {
                                                'unit': 1    
                                            },
                                            'downlink': {
                                                'unit': 1    
                                            }
                                        },
                                        'arp': {
                                            'priority_level': 4,
                                            'pre_emption_capability': 2,
                                            'pre_emption_vulnerability': 2
                                        }
                                    },
                                    'flow': []
                                }
                            ],
                            'ambr': {
                                    'uplink': {
                                        'value': 1,
                                        'unit': 3
                                    },
                                    'downlink': {
                                        'value': 1,
                                        'unit': 3
                                    }
                            },
                            'qos': {
                                'index': 5,
                                'arp': {
                                    'priority_level': 1,
                                    'pre_emption_capability': 1,
                                    'pre_emption_vulnerability': 1
                                }
                            }
                        }
                    ]
                }    
            ],
            'ambr': {
                'uplink': {
                    'value': 1,
                    'unit': 3
                },
                'downlink': {
                    'value': 1,
                    'unit': 3
                }
            },
            'security': {
                'k': '',
                'amf': '',
                'op': '',
                'opc': None
            },
            'purge_flag': [],
            'mme_realm': [],
            'mme_host': [],
            'imeisv': [],
            'msisdn': [],
            'schema_version': 1,
            '__v': 0
}

subs_config = [
    {
        'imsi': '001010123456780',
        'k': '11112233445566778899aabbccddeeff',
        'op': '11111111111111111111111111111111',
        'amf': '8000'
    },
    {
        'imsi': '001010123456781',
        'k': '22112233445566778899aabbccddeeff',
        'op': '11111111111111111111111111111111',
        'amf': '8000'
    }
]   

def fill_data_subs(data):
    ue = profile_default
    ue['imsi'] = data['imsi']
    ue['security']['k'] = data['k']
    ue['security']['op'] = data['op']
    ue['security']['amf'] = data['amf']
    return deepcopy(ue)

subs_array = [fill_data_subs(sub) for sub in subs_config]

insert = sub_collection.insert_many(subs_array)

connection.close()
