configs.pets = {
    ['jaguatirica'] = {
        type = 'jaguatirica',
        ped = 'a_c_mtlion',
        c_hunger = 150,
        c_thirst = 150,
        default_variation = 0,
        variations = false,
        actions = {
            ['sit'] = {
                permission = false,
            }, 
            ['attack'] = {
                permission = true,
            }, 
            ['liedown'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                animName = 'sleep_in_kennel'
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = true,
            } 
        },
    },
    ['pantera'] = {
        type = 'pantera',
        ped = 'a_c_panther',
        c_hunger = 150,
        c_thirst = 150,
        default_variation = 0,
        variations = false,
        actions = {
            ['sit'] = {
                permission = false,
            }, 
            ['attack'] = {
                permission = true,
            }, 
            ['liedown'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                animName = 'sleep_in_kennel'
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = true,
            } 
        },
    },
    ['husky'] = {
        type = 'husky',
        ped = 'a_c_husky',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        variations = { '#808080', '#663300', '#ffffff' },
        actions = {
            ['sit'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@world_dog_sitting@base',
                animName = 'base'
            }, 
            ['attack'] = {
                permission = true,
            }, 
            ['liedown'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                animName = 'sleep_in_kennel'
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = true,
            } 
        },
    },
    ['cat'] = {
        type = 'cat',
        ped = 'a_c_cat_01',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        variations = { '#808080', '#000000', '#663300'},
        actions = {
            ['sit'] = {
                permission = false,
                animDict = 'creatures@poodle@amb@world_dog_sitting@base',
                animName = 'base'
            }, 
            ['attack'] = {
                permission = false,
            }, 
            ['liedown'] = {
                permission = true,
                animDict = 'creatures@cat@amb@world_cat_sleeping_ground@base',
                animName = 'base'
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = false,
            } 
        },
    },
    ['pug'] = {
        type = 'pug',
        ped = 'a_c_pug',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        type_variation = 'texture',
        variations = { '#808080', '#663300', '#ffffff' },
        actions = {
            ['sit'] = {
                permission = false,
            }, 
            ['attack'] = {
                permission = false,
            }, 
            ['liedown'] = {
                permission = false,
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = false,
            } 
        },
    },
    ['poodle'] = {
        type = 'poodle',
        ped = 'a_c_poodle',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        variations = false,
        actions = {
            ['sit'] = {
                permission = false,
            }, 
            ['attack'] = {
                permission = false,
            }, 
            ['liedown'] = {
                permission = false,
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = false,
            } 
        },
    },
    -- ['westy'] = {
    --     type = 'westy',
    --     ped = 'a_c_westy',
    --     c_hunger = 100,
    --     c_thirst = 100,
    --     default_variation = 0,
    --     variations = { '#808080', '#663300', '#ffffff' },
    --     actions = {
    --         ['sit'] = {
    --             permission = false,
    --         }, 
    --         ['attack'] = {
    --             permission = false,
    --         }, 
    --         ['liedown'] = {
    --             permission = false,
    --         }, 
    --         ['follow'] = {
    --             permission = true,
    --         }, 
    --         ['home'] = {
    --             permission = true,
    --         },
    --         ['ball'] = {
    --             permission = false,
    --         } 
    --     },
    -- },
    ['shepherd'] = {
        type = 'shepherd',
        ped = 'a_c_shepherd',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        variations = { '#000000', '#ffffff', '#663300' },
        actions = {
            ['sit'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@world_dog_sitting@base',
                animName = 'base'
            }, 
            ['attack'] = {
                permission = true,
            }, 
            ['liedown'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                animName = 'sleep_in_kennel'
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = true,
            } 
        },
    },
    ['rottweiler'] = {
        type = 'rottweiler',
        ped = 'a_c_chop',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        variations = false,
        actions = {
            ['sit'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@world_dog_sitting@base',
                animName = 'base'
            }, 
            ['attack'] = {
                permission = true,
            }, 
            ['liedown'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                animName = 'sleep_in_kennel'
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = true,
            } 
        },
    },
    ['retriever'] = {
        type = 'retriever',
        ped = 'a_c_retriever',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        variations = { '#ffe6e6', '#000000', '#ffffff' },
        actions = {
            ['sit'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@world_dog_sitting@base',
                animName = 'base'
            }, 
            ['attack'] = {
                permission = true,
            }, 
            ['liedown'] = {
                permission = true,
                animDict = 'creatures@rottweiler@amb@sleep_in_kennel@',
                animName = 'sleep_in_kennel'
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = true,
            } 
        },
    },
    ['rabbit'] = {
        type = 'rabbit',
        ped = 'a_c_rabbit_01',
        c_hunger = 100,
        c_thirst = 100,
        default_variation = 0,
        variations = false,
        actions = {
            ['sit'] = {
                permission = false,
            }, 
            ['attack'] = {
                permission = false,
            }, 
            ['liedown'] = {
                permission = false,
            }, 
            ['follow'] = {
                permission = true,
            }, 
            ['home'] = {
                permission = true,
            },
            ['ball'] = {
                permission = false,
            } 
        },
    },
    
}