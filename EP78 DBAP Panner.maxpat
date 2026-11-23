{
    "patcher": {
        "fileversion": 1,
        "appversion": {
            "major": 9,
            "minor": 1,
            "revision": 2,
            "architecture": "x64",
            "modernui": 1
        },
        "classnamespace": "box",
        "rect": [ -1672.0, 574.0, 1669.0, 954.0 ],
        "openinpresentation": 1,
        "toolbarvisible": 0,
        "boxes": [
            {
                "box": {
                    "angle": 270.0,
                    "bgcolor": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 0.0 ],
                    "border": 5,
                    "bordercolor": [ 0.09019607843137255, 0.2901960784313726, 0.6313725490196078, 1.0 ],
                    "id": "obj-14",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 649.0, 710.0, 38.0, 41.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1279.0, 9.0, 280.0, 32.0 ],
                    "proportion": 0.5
                }
            },
            {
                "box": {
                    "filename": "dbab_modehelp.js",
                    "id": "obj-13",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "parameter_enable": 0,
                    "patching_rect": [ 1014.0, 812.0, 64.0, 64.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1072.0, 564.0, 401.0, 383.0 ],
                    "textfile": {
                        "filename": "dbab_modehelp.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-20",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 543.0, 79.0, 42.0, 22.0 ],
                    "text": "mute~"
                }
            },
            {
                "box": {
                    "id": "obj-3",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 2093.0, 556.0, 81.0, 22.0 ],
                    "text": "loadmess -20"
                }
            },
            {
                "box": {
                    "id": "obj-103",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 1572.0, 453.0, 1000.0, 780.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-21",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 157.0, 133.0, 22.0, 22.0 ],
                                    "text": "t 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-16",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "patching_rect": [ 129.5, 133.0, 22.0, 22.0 ],
                                    "text": "t 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-13",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 129.5, 100.0, 34.0, 22.0 ],
                                    "text": "sel 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-14",
                                    "maxclass": "toggle",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "int" ],
                                    "parameter_enable": 0,
                                    "patching_rect": [ 50.0, 125.0, 24.0, 24.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-100",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 129.5, 40.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-101",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 50.0, 245.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "source": [ "obj-100", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "source": [ "obj-13", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-13", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-101", 0 ],
                                    "source": [ "obj-14", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-16", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-21", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 543.0, 45.0, 176.0, 22.0 ],
                    "text": "p practice_DSP_enable/disable"
                }
            },
            {
                "box": {
                    "id": "obj-97",
                    "maxclass": "newobj",
                    "numinlets": 7,
                    "numoutlets": 3,
                    "outlettype": [ "", "signal", "signal" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ -1490.0, 630.0, 1000.0, 780.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-143",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 442.0, 410.9725849032402, 69.0, 22.0 ],
                                    "text": "0 0 0, 1 1 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-145",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 366.66666666666663, 410.9725849032402, 69.0, 22.0 ],
                                    "text": "2 0 0, 3 1 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-141",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 442.0, 382.9725849032402, 69.0, 22.0 ],
                                    "text": "2 0 1, 3 1 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-139",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 366.66666666666663, 382.9725849032402, 69.0, 22.0 ],
                                    "text": "0 0 1, 1 1 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-135",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 2,
                                    "outlettype": [ "signal", "signal" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 0.0, 0.0, 1000.0, 780.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-128",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "signal" ],
                                                    "patcher": {
                                                        "fileversion": 1,
                                                        "appversion": {
                                                            "major": 9,
                                                            "minor": 1,
                                                            "revision": 2,
                                                            "architecture": "x64",
                                                            "modernui": 1
                                                        },
                                                        "classnamespace": "box",
                                                        "rect": [ 0.0, 0.0, 1000.0, 780.0 ],
                                                        "boxes": [
                                                            {
                                                                "box": {
                                                                    "id": "obj-88",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 209.0, 103.0, 40.0, 22.0 ],
                                                                    "text": "*~ 0.7"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-65",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 50.0, 100.0, 40.0, 22.0 ],
                                                                    "text": "*~ 0.7"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "comment": "",
                                                                    "id": "obj-125",
                                                                    "index": 1,
                                                                    "maxclass": "inlet",
                                                                    "numinlets": 0,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 50.0, 40.0, 30.0, 30.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "comment": "",
                                                                    "id": "obj-126",
                                                                    "index": 2,
                                                                    "maxclass": "inlet",
                                                                    "numinlets": 0,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 209.0, 40.0, 30.0, 30.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "comment": "",
                                                                    "id": "obj-127",
                                                                    "index": 1,
                                                                    "maxclass": "outlet",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 123.5, 185.0, 30.0, 30.0 ]
                                                                }
                                                            }
                                                        ],
                                                        "lines": [
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-65", 0 ],
                                                                    "source": [ "obj-125", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-88", 0 ],
                                                                    "source": [ "obj-126", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-127", 0 ],
                                                                    "source": [ "obj-65", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-127", 0 ],
                                                                    "source": [ "obj-88", 0 ]
                                                                }
                                                            }
                                                        ]
                                                    },
                                                    "patching_rect": [ 50.0, 100.0, 54.0, 22.0 ],
                                                    "text": "p FL_BL"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-119",
                                                    "maxclass": "newobj",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "signal" ],
                                                    "patcher": {
                                                        "fileversion": 1,
                                                        "appversion": {
                                                            "major": 9,
                                                            "minor": 1,
                                                            "revision": 2,
                                                            "architecture": "x64",
                                                            "modernui": 1
                                                        },
                                                        "classnamespace": "box",
                                                        "rect": [ 0.0, 0.0, 1000.0, 780.0 ],
                                                        "boxes": [
                                                            {
                                                                "box": {
                                                                    "id": "obj-79",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 209.0, 103.10000818967819, 40.0, 22.0 ],
                                                                    "text": "*~ 0.7"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "id": "obj-73",
                                                                    "maxclass": "newobj",
                                                                    "numinlets": 2,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 50.0, 100.0, 40.0, 22.0 ],
                                                                    "text": "*~ 0.7"
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "comment": "",
                                                                    "id": "obj-112",
                                                                    "index": 1,
                                                                    "maxclass": "inlet",
                                                                    "numinlets": 0,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 50.0, 40.0, 30.0, 30.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "comment": "",
                                                                    "id": "obj-117",
                                                                    "index": 2,
                                                                    "maxclass": "inlet",
                                                                    "numinlets": 0,
                                                                    "numoutlets": 1,
                                                                    "outlettype": [ "signal" ],
                                                                    "patching_rect": [ 209.0, 40.0, 30.0, 30.0 ]
                                                                }
                                                            },
                                                            {
                                                                "box": {
                                                                    "comment": "",
                                                                    "id": "obj-118",
                                                                    "index": 1,
                                                                    "maxclass": "outlet",
                                                                    "numinlets": 1,
                                                                    "numoutlets": 0,
                                                                    "patching_rect": [ 123.5, 185.10003700000004, 30.0, 30.0 ]
                                                                }
                                                            }
                                                        ],
                                                        "lines": [
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-73", 0 ],
                                                                    "source": [ "obj-112", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-79", 0 ],
                                                                    "source": [ "obj-117", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-118", 0 ],
                                                                    "source": [ "obj-73", 0 ]
                                                                }
                                                            },
                                                            {
                                                                "patchline": {
                                                                    "destination": [ "obj-118", 0 ],
                                                                    "source": [ "obj-79", 0 ]
                                                                }
                                                            }
                                                        ]
                                                    },
                                                    "patching_rect": [ 113.0, 100.0, 58.0, 22.0 ],
                                                    "text": "p FR_BR"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-129",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "signal" ],
                                                    "patching_rect": [ 50.0, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-130",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "signal" ],
                                                    "patching_rect": [ 85.0, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-131",
                                                    "index": 3,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "signal" ],
                                                    "patching_rect": [ 120.0, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-132",
                                                    "index": 4,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "signal" ],
                                                    "patching_rect": [ 152.0, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-133",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 50.0, 182.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-134",
                                                    "index": 2,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 113.0, 182.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-134", 0 ],
                                                    "source": [ "obj-119", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-133", 0 ],
                                                    "source": [ "obj-128", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-128", 0 ],
                                                    "source": [ "obj-129", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-128", 1 ],
                                                    "source": [ "obj-130", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-119", 0 ],
                                                    "source": [ "obj-131", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-119", 1 ],
                                                    "source": [ "obj-132", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 797.0, 165.0, 53.0, 22.0 ],
                                    "text": "p QUAD"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-55",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 517.0, 681.1725769042969, 45.0, 22.0 ],
                                    "text": "dac~ 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-90",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 455.0, 681.1725769042969, 52.0, 22.0 ],
                                    "text": "dac~ 29"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-107",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 3,
                                    "outlettype": [ "signal", "signal", "" ],
                                    "patching_rect": [ 455.0, 534.1725769042969, 68.0, 22.0 ],
                                    "text": "matrix~ 4 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-63",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 59.0, 106.0, 1000.0, 780.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-2",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 182.0, 72.0, 275.0, 22.0 ],
                                                    "text": "set Headphone Monitor (post-QUAD) OUT CH 1/2"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-1",
                                                    "index": 3,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "bang" ],
                                                    "patching_rect": [ 182.0, 13.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-51",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 63.0, 100.0, 278.0, 22.0 ],
                                                    "text": "set Headphone Monitor (pre-panning) OUT CH 1/2"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-36",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 50.0, 133.0, 268.0, 22.0 ],
                                                    "text": "set Headphone Monitor (pre-panning) OUT CH 5"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-56",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "bang" ],
                                                    "patching_rect": [ 50.0, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-60",
                                                    "index": 2,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "bang" ],
                                                    "patching_rect": [ 85.0, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-61",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 50.5, 215.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-2", 0 ],
                                                    "source": [ "obj-1", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-61", 0 ],
                                                    "source": [ "obj-2", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-61", 0 ],
                                                    "source": [ "obj-36", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-61", 0 ],
                                                    "source": [ "obj-51", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-36", 0 ],
                                                    "source": [ "obj-56", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-51", 0 ],
                                                    "source": [ "obj-60", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 50.0, 711.0, 44.0, 22.0 ],
                                    "text": "p label"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-58",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 644.0, 237.3725706934929, 35.0, 22.0 ],
                                    "text": "set 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-57",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 553.0, 237.3725706934929, 35.0, 22.0 ],
                                    "text": "set 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-45",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 507.0, 237.3725706934929, 41.0, 22.0 ],
                                    "text": "set 29"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-44",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 4,
                                    "outlettype": [ "bang", "bang", "bang", "" ],
                                    "patching_rect": [ 355.0, 116.0, 54.0, 22.0 ],
                                    "text": "sel 0 1 2"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-33",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 602.0, 237.3725706934929, 35.0, 22.0 ],
                                    "text": "set 1"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-60",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 355.0, 39.999999904296885, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-61",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 455.0, 39.999999904296885, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-65",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 490.0, 39.999999904296885, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-73",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 797.0, 116.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-79",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 832.0, 116.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-88",
                                    "index": 6,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 867.0, 116.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-89",
                                    "index": 7,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 902.0, 116.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-91",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 50.0, 763.1725769042969, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-92",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 373.0, 677.1725769042969, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-93",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 408.0, 677.1725769042969, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-55", 0 ],
                                    "order": 0,
                                    "source": [ "obj-107", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-90", 0 ],
                                    "order": 0,
                                    "source": [ "obj-107", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-92", 0 ],
                                    "order": 1,
                                    "source": [ "obj-107", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-93", 0 ],
                                    "order": 1,
                                    "source": [ "obj-107", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 3 ],
                                    "source": [ "obj-135", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 2 ],
                                    "source": [ "obj-135", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 0 ],
                                    "source": [ "obj-139", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 0 ],
                                    "source": [ "obj-141", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 0 ],
                                    "source": [ "obj-143", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 0 ],
                                    "source": [ "obj-145", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-90", 0 ],
                                    "source": [ "obj-33", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-139", 0 ],
                                    "order": 3,
                                    "source": [ "obj-44", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-141", 0 ],
                                    "order": 3,
                                    "source": [ "obj-44", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-143", 0 ],
                                    "order": 2,
                                    "source": [ "obj-44", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-145", 0 ],
                                    "order": 2,
                                    "source": [ "obj-44", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-33", 0 ],
                                    "order": 1,
                                    "source": [ "obj-44", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-33", 0 ],
                                    "midpoints": [ 376.1666666666667, 188.67257690429688, 611.5, 188.67257690429688 ],
                                    "order": 1,
                                    "source": [ "obj-44", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-45", 0 ],
                                    "order": 1,
                                    "source": [ "obj-44", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-57", 0 ],
                                    "midpoints": [ 364.5, 198.56057739257812, 562.5, 198.56057739257812 ],
                                    "order": 0,
                                    "source": [ "obj-44", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-58", 0 ],
                                    "order": 0,
                                    "source": [ "obj-44", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-58", 0 ],
                                    "midpoints": [ 376.1666666666667, 188.67257690429688, 653.5, 188.67257690429688 ],
                                    "order": 0,
                                    "source": [ "obj-44", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-63", 2 ],
                                    "midpoints": [ 387.8333333333333, 369.0, 84.5, 369.0 ],
                                    "order": 4,
                                    "source": [ "obj-44", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-63", 1 ],
                                    "midpoints": [ 376.1666666666667, 369.0, 72.0, 369.0 ],
                                    "order": 4,
                                    "source": [ "obj-44", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-63", 0 ],
                                    "midpoints": [ 364.5, 369.0, 59.5, 369.0 ],
                                    "order": 2,
                                    "source": [ "obj-44", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-90", 0 ],
                                    "source": [ "obj-45", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-55", 0 ],
                                    "source": [ "obj-57", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-55", 0 ],
                                    "source": [ "obj-58", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-44", 0 ],
                                    "source": [ "obj-60", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 0 ],
                                    "source": [ "obj-61", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-91", 0 ],
                                    "source": [ "obj-63", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-107", 1 ],
                                    "source": [ "obj-65", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-135", 0 ],
                                    "source": [ "obj-73", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-135", 1 ],
                                    "source": [ "obj-79", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-135", 2 ],
                                    "source": [ "obj-88", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-135", 3 ],
                                    "source": [ "obj-89", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 418.0, 485.0, 113.0, 22.0 ],
                    "text": "p monitor_selection"
                }
            },
            {
                "box": {
                    "fontsize": 12.0,
                    "id": "obj-12",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 438.0, 381.0, 233.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1304.0, 76.0, 229.00000309944153, 20.0 ],
                    "text": "Practice (Laptop) - Post-Pan Monitoring"
                }
            },
            {
                "box": {
                    "fontsize": 12.0,
                    "id": "obj-10",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 438.0, 351.0, 233.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1304.0, 45.0, 259.0, 20.0 ],
                    "text": "Practice (Laptop) - Direct-in Monitoring"
                }
            },
            {
                "box": {
                    "id": "obj-149",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 513.0, 529.0, 26.0, 60.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1213.0, 265.0, 25.0, 95.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-146",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 466.0, 529.0, 26.0, 60.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1184.0, 265.0, 25.0, 95.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-59",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 418.0, 285.0, 70.0, 22.0 ],
                    "text": "loadmess 0"
                }
            },
            {
                "box": {
                    "fontsize": 12.0,
                    "id": "obj-39",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 438.0, 322.0, 254.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1304.0, 16.0, 251.0, 20.0 ],
                    "text": "Array Routing - Direct-In Monitoring (Default) "
                }
            },
            {
                "box": {
                    "disabled": [ 0, 0, 0 ],
                    "id": "obj-37",
                    "itemtype": 0,
                    "maxclass": "radiogroup",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "offset": 30,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 418.0, 322.0, 18.0, 92.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1284.0, 16.0, 18.0, 92.0 ],
                    "size": 3,
                    "value": 0
                }
            },
            {
                "box": {
                    "id": "obj-11",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 23,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ -1646.0, 663.0, 1135.0, 780.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-30",
                                    "index": 23,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 987.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-29",
                                    "index": 22,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 946.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-28",
                                    "index": 21,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 905.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-27",
                                    "index": 20,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 864.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-26",
                                    "index": 19,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 823.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-25",
                                    "index": 18,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 782.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-24",
                                    "index": 17,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 741.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-23",
                                    "index": 16,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 700.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-22",
                                    "index": 15,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 659.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-21",
                                    "index": 14,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 618.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-20",
                                    "index": 13,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 577.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-19",
                                    "index": 12,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 536.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-18",
                                    "index": 11,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 495.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-17",
                                    "index": 10,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 454.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-16",
                                    "index": 9,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 413.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-15",
                                    "index": 8,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 372.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-14",
                                    "index": 7,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 331.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-13",
                                    "index": 6,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 290.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-12",
                                    "index": 5,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 249.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-11",
                                    "index": 4,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 208.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-10",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 167.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-9",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 126.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-8",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 85.0, 374.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-7",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 85.0, 256.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 23,
                                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal" ],
                                    "patching_rect": [ 84.9090909090909, 323.0, 923.0, 22.0 ],
                                    "text": "gen~ dbap_testsignals.gendsp"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-10", 0 ],
                                    "source": [ "obj-1", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-11", 0 ],
                                    "source": [ "obj-1", 3 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-12", 0 ],
                                    "source": [ "obj-1", 4 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-13", 0 ],
                                    "source": [ "obj-1", 5 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-14", 0 ],
                                    "source": [ "obj-1", 6 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-15", 0 ],
                                    "source": [ "obj-1", 7 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-16", 0 ],
                                    "source": [ "obj-1", 8 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-17", 0 ],
                                    "source": [ "obj-1", 9 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-18", 0 ],
                                    "source": [ "obj-1", 10 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-19", 0 ],
                                    "source": [ "obj-1", 11 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-20", 0 ],
                                    "source": [ "obj-1", 12 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-21", 0 ],
                                    "source": [ "obj-1", 13 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-22", 0 ],
                                    "source": [ "obj-1", 14 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-1", 15 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-1", 16 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-25", 0 ],
                                    "source": [ "obj-1", 17 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "source": [ "obj-1", 18 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 0 ],
                                    "source": [ "obj-1", 19 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-28", 0 ],
                                    "source": [ "obj-1", 20 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-29", 0 ],
                                    "source": [ "obj-1", 21 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-30", 0 ],
                                    "source": [ "obj-1", 22 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-8", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "source": [ "obj-1", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-1", 0 ],
                                    "source": [ "obj-7", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 543.0, 113.0, 305.0, 22.0 ],
                    "text": "p practice_audio"
                }
            },
            {
                "box": {
                    "bgoncolor": [ 0.6470588235294118, 0.18823529411764706, 0.18823529411764706, 1.0 ],
                    "id": "obj-8",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 47.0, 1077.0, 152.80000227689743, 49.199993789196014 ],
                    "presentation": 1,
                    "presentation_rect": [ 1421.0, 172.0, 152.80000227689743, 49.199993789196014 ],
                    "text": "VIEW INPUT LIST",
                    "texton": "VIEW INPUT LIST",
                    "usebgoncolor": 1
                }
            },
            {
                "box": {
                    "id": "obj-1",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ -1646.0, 590.0, 1161.0, 870.0 ],
                        "openinpresentation": 1,
                        "toolbarvisible": 0,
                        "enablehscroll": 0,
                        "enablevscroll": 0,
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 7.0, 473.0, 67.0, 22.0 ],
                                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                                    "text": "thispatcher"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "front" ],
                                    "patching_rect": [ 7.0, 443.0, 39.0, 22.0 ],
                                    "text": "t front"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 7.0, 408.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "disablefind": 0,
                                    "id": "obj-1",
                                    "maxclass": "jweb",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 2.0, 1.0, 519.0, 384.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 2.0, 1.0, 1157.0, 867.0 ],
                                    "rendermode": 2,
                                    "url": "https://docs.google.com/spreadsheets/d/e/2PACX-1vQZQnJnCsoqGr0SHpVvCS0I8iL-Aj4MDizxCISueQoWyh7Q3xNqA1HY47f0nnsB7gfgBDcc8aWk86v9/pubhtml?gid=1471611789&single=true"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 47.0, 1143.0, 66.0, 22.0 ],
                    "text": "p input_list"
                }
            },
            {
                "box": {
                    "bgoncolor": [ 0.6470588235294118, 0.18823529411764706, 0.18823529411764706, 1.0 ],
                    "id": "obj-180",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 47.0, 978.0, 152.80000227689743, 49.199993789196014 ],
                    "presentation": 1,
                    "presentation_rect": [ 1421.0, 116.0, 152.80000227689743, 49.199993789196014 ],
                    "text": "HOW-TO GUIDE",
                    "texton": "Opening",
                    "usebgoncolor": 1
                }
            },
            {
                "box": {
                    "id": "obj-179",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 842.0, 231.0, 798.0, 650.0 ],
                        "openinpresentation": 1,
                        "toolbarvisible": 0,
                        "enablehscroll": 0,
                        "enablevscroll": 0,
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 650.0, 496.0, 67.0, 22.0 ],
                                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                                    "text": "thispatcher"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-2",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 650.0, 383.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-1",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "front" ],
                                    "patching_rect": [ 650.0, 440.0, 39.0, 22.0 ],
                                    "text": "t front"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-178",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 100.0, 87.0, 22.0 ],
                                    "text": "loadmess path"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-176",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 98.0, 160.8000009059906, 203.0, 22.0 ],
                                    "text": "sprintf readfile %spanner_guide.html"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-173",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 50.0, 130.4000004529953, 67.0, 22.0 ],
                                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                                    "text": "thispatcher"
                                }
                            },
                            {
                                "box": {
                                    "disablefind": 0,
                                    "id": "obj-172",
                                    "maxclass": "jweb",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 98.0, 198.0, 389.0, 384.0 ],
                                    "presentation": 1,
                                    "presentation_rect": [ 0.0, 0.0, 798.0, 649.0 ],
                                    "rendermode": 0,
                                    "url": "file://panner_guide.html"
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-1", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-176", 0 ],
                                    "source": [ "obj-173", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-172", 0 ],
                                    "source": [ "obj-176", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-173", 0 ],
                                    "source": [ "obj-178", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-1", 0 ],
                                    "source": [ "obj-2", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 47.0, 1044.0, 93.0, 22.0 ],
                    "text": "p how_to_guide"
                }
            },
            {
                "box": {
                    "id": "obj-171",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1500.0, 675.0, 100.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1284.0, 114.0, 92.80000138282776, 36.80000054836273 ],
                    "text": "Reset Show",
                    "texton": "Reset Show"
                }
            },
            {
                "box": {
                    "id": "obj-170",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1500.0, 704.0, 63.0, 22.0 ],
                    "text": "resetshow"
                }
            },
            {
                "box": {
                    "id": "obj-168",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "" ],
                    "patching_rect": [ 1325.0, 210.0, 47.0, 22.0 ],
                    "text": "zl.nth 2"
                }
            },
            {
                "box": {
                    "id": "obj-167",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 1325.0, 158.0, 29.5, 22.0 ],
                    "text": "+ 1"
                }
            },
            {
                "box": {
                    "coll_data": {
                        "count": 6,
                        "data": [
                            {
                                "key": 1,
                                "value": [ "ensemble1" ]
                            },
                            {
                                "key": 2,
                                "value": [ "ensemble2" ]
                            },
                            {
                                "key": 3,
                                "value": [ "switchemups1" ]
                            },
                            {
                                "key": 4,
                                "value": [ "switchemups2" ]
                            },
                            {
                                "key": 5,
                                "value": [ "switchemups3" ]
                            },
                            {
                                "key": 6,
                                "value": [ "switchemups4" ]
                            }
                        ]
                    },
                    "id": "obj-162",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 4,
                    "outlettype": [ "", "", "", "" ],
                    "patching_rect": [ 1325.0, 185.0, 89.0, 22.0 ],
                    "saved_object_attributes": {
                        "embed": 1,
                        "precision": 6
                    },
                    "text": "coll @embed 1"
                }
            },
            {
                "box": {
                    "id": "obj-161",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1325.0, 238.0, 88.0, 22.0 ],
                    "text": "prepend scene"
                }
            },
            {
                "box": {
                    "id": "obj-160",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1346.0, 126.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1097.0, 159.0, 150.0, 20.0 ],
                    "text": "Switchemups 4"
                }
            },
            {
                "box": {
                    "id": "obj-159",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1346.0, 103.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1097.0, 136.0, 150.0, 20.0 ],
                    "text": "Switchemups 3"
                }
            },
            {
                "box": {
                    "id": "obj-158",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1346.0, 80.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1097.0, 114.0, 150.0, 20.0 ],
                    "text": "Switchemups 2"
                }
            },
            {
                "box": {
                    "id": "obj-157",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 696.0, 772.0, 72.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "fontsize": 12.0,
                    "id": "obj-155",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 696.0, 818.0, 111.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1192.0, 488.0, 208.00000309944153, 20.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-154",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 605.0, 772.0, 79.0, 22.0 ],
                    "text": "loadmess set"
                }
            },
            {
                "box": {
                    "fontsize": 20.0,
                    "id": "obj-153",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 472.0, 819.0, 140.0, 29.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1192.0, 452.0, 151.20000225305557, 29.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-151",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 472.0, 783.0, 72.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "id": "obj-148",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 472.0, 754.0, 91.0, 22.0 ],
                    "text": "sprintf %i:%i:%i"
                }
            },
            {
                "box": {
                    "bgoncolor": [ 0.6470588235294118, 0.18823529411764706, 0.18823529411764706, 1.0 ],
                    "id": "obj-147",
                    "maxclass": "textbutton",
                    "mode": 1,
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 605.0, 634.0, 152.80000227689743, 49.199993789196014 ],
                    "presentation": 1,
                    "presentation_rect": [ 1190.0, 395.0, 152.80000227689743, 49.199993789196014 ],
                    "text": "RECORDING STOPPED",
                    "texton": "RECORDING",
                    "usebgoncolor": 1
                }
            },
            {
                "box": {
                    "id": "obj-144",
                    "maxclass": "newobj",
                    "numinlets": 5,
                    "numoutlets": 3,
                    "outlettype": [ "", "bang", "" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ -1386.0, 617.0, 1000.0, 780.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-27",
                                    "index": 3,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 755.0, 423.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-26",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 755.0, 368.0, 293.0, 22.0 ],
                                    "text": "sprintf recording to EP_78_Quad_Recording_%s.wav"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-24",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patcher": {
                                        "fileversion": 1,
                                        "appversion": {
                                            "major": 9,
                                            "minor": 1,
                                            "revision": 2,
                                            "architecture": "x64",
                                            "modernui": 1
                                        },
                                        "classnamespace": "box",
                                        "rect": [ 0.0, 0.0, 1000.0, 780.0 ],
                                        "boxes": [
                                            {
                                                "box": {
                                                    "id": "obj-20",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "bang" ],
                                                    "patching_rect": [ 50.0, 100.0, 58.0, 22.0 ],
                                                    "text": "loadbang"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-14",
                                                    "linecount": 7,
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 67.0, 219.0, 50.0, 102.0 ],
                                                    "text": "MacSSD:/Users/michaelpalumbo/exitpoints-vbap/"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-12",
                                                    "maxclass": "message",
                                                    "numinlets": 2,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "" ],
                                                    "patching_rect": [ 50.0, 128.0, 32.0, 22.0 ],
                                                    "text": "path"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "id": "obj-10",
                                                    "maxclass": "newobj",
                                                    "numinlets": 1,
                                                    "numoutlets": 2,
                                                    "outlettype": [ "", "" ],
                                                    "patching_rect": [ 50.0, 186.0, 67.0, 22.0 ],
                                                    "save": [ "#N", "thispatcher", ";", "#Q", "end", ";" ],
                                                    "text": "thispatcher"
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-21",
                                                    "index": 1,
                                                    "maxclass": "inlet",
                                                    "numinlets": 0,
                                                    "numoutlets": 1,
                                                    "outlettype": [ "bang" ],
                                                    "patching_rect": [ 67.0, 40.0, 30.0, 30.0 ]
                                                }
                                            },
                                            {
                                                "box": {
                                                    "comment": "",
                                                    "id": "obj-22",
                                                    "index": 1,
                                                    "maxclass": "outlet",
                                                    "numinlets": 1,
                                                    "numoutlets": 0,
                                                    "patching_rect": [ 67.0, 381.0, 30.0, 30.0 ]
                                                }
                                            }
                                        ],
                                        "lines": [
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-14", 1 ],
                                                    "source": [ "obj-10", 1 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-10", 0 ],
                                                    "source": [ "obj-12", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-22", 0 ],
                                                    "source": [ "obj-14", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-12", 0 ],
                                                    "source": [ "obj-20", 0 ]
                                                }
                                            },
                                            {
                                                "patchline": {
                                                    "destination": [ "obj-14", 0 ],
                                                    "source": [ "obj-21", 0 ]
                                                }
                                            }
                                        ]
                                    },
                                    "patching_rect": [ 402.0, 336.0, 58.0, 22.0 ],
                                    "text": "p pathing"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-19",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "" ],
                                    "patching_rect": [ 402.0, 294.0, 31.0, 22.0 ],
                                    "text": "t b s"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-9",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 311.0, 330.0, 55.0, 22.0 ],
                                    "text": "pipe 100"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-6",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "bang" ],
                                    "patching_rect": [ 262.8000044822693, 540.0, 48.0, 22.0 ],
                                    "text": "del 500"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-5",
                                    "index": 2,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 262.8000044822693, 612.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-4",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 2,
                                    "outlettype": [ "bang", "int" ],
                                    "patching_rect": [ 262.8000044822693, 288.0, 41.0, 22.0 ],
                                    "text": "t b i"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-3",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "int", "int" ],
                                    "patching_rect": [ 87.0, 534.0, 48.0, 22.0 ],
                                    "text": "change"
                                }
                            },
                            {
                                "box": {
                                    "fontname": "Arial",
                                    "fontsize": 13.0,
                                    "id": "obj-23",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 87.0, 570.0, 139.0, 23.0 ],
                                    "text": "translate ms hh:mm:ss"
                                }
                            },
                            {
                                "box": {
                                    "fontface": 0,
                                    "fontname": "Arial",
                                    "fontsize": 12.0,
                                    "id": "obj-2",
                                    "maxclass": "number~",
                                    "mode": 2,
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "signal", "float" ],
                                    "patching_rect": [ 50.0, 481.0, 56.0, 22.0 ],
                                    "sig": 0.0
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-1",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 87.0, 614.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-136",
                                    "maxclass": "newobj",
                                    "numinlets": 3,
                                    "numoutlets": 3,
                                    "outlettype": [ "", "", "" ],
                                    "patching_rect": [ 263.0, 106.0, 119.0, 22.0 ],
                                    "text": "routepass 0 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-133",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "int", "date", "time" ],
                                    "patching_rect": [ 313.0, 153.0, 108.0, 22.0 ],
                                    "text": "t 1 date time"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-132",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 402.0, 263.0, 133.0, 22.0 ],
                                    "text": "tosymbol @separator _"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-131",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 2,
                                    "outlettype": [ "", "" ],
                                    "patching_rect": [ 402.0, 231.0, 39.0, 22.0 ],
                                    "text": "zl.join"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-121",
                                    "maxclass": "newobj",
                                    "numinlets": 1,
                                    "numoutlets": 3,
                                    "outlettype": [ "list", "list", "int" ],
                                    "patching_rect": [ 402.0, 199.0, 59.0, 22.0 ],
                                    "text": "date"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-118",
                                    "maxclass": "newobj",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 402.0, 368.0, 325.0, 22.0 ],
                                    "text": "sprintf open %srecordings/EP78_Quad_Recording_%s.wav"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-117",
                                    "maxclass": "newobj",
                                    "numinlets": 4,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 49.99999278783798, 431.0, 144.0, 22.0 ],
                                    "text": "sfrecord~ 4 @bitdepth 24"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-139",
                                    "index": 1,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 49.99999278783798, 321.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-140",
                                    "index": 2,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 90.99999278783798, 321.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-141",
                                    "index": 3,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 132.99999278783798, 321.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-142",
                                    "index": 4,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "signal" ],
                                    "patching_rect": [ 174.99999278783798, 321.0, 30.0, 30.0 ]
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-143",
                                    "index": 5,
                                    "maxclass": "inlet",
                                    "numinlets": 0,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 263.0, 32.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-2", 0 ],
                                    "source": [ "obj-117", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-117", 0 ],
                                    "midpoints": [ 411.5, 402.0, 59.49999278783798, 402.0 ],
                                    "source": [ "obj-118", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-131", 1 ],
                                    "source": [ "obj-121", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-131", 0 ],
                                    "source": [ "obj-121", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-132", 0 ],
                                    "source": [ "obj-131", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-19", 0 ],
                                    "source": [ "obj-132", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-121", 0 ],
                                    "midpoints": [ 411.5, 187.0, 411.5, 187.0 ],
                                    "source": [ "obj-133", 2 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-121", 0 ],
                                    "midpoints": [ 367.0, 193.0, 411.5, 193.0 ],
                                    "source": [ "obj-133", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-9", 0 ],
                                    "source": [ "obj-133", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-133", 0 ],
                                    "source": [ "obj-136", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-4", 0 ],
                                    "source": [ "obj-136", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-117", 0 ],
                                    "source": [ "obj-139", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-117", 1 ],
                                    "source": [ "obj-140", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-117", 2 ],
                                    "source": [ "obj-141", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-117", 3 ],
                                    "source": [ "obj-142", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-136", 0 ],
                                    "source": [ "obj-143", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-118", 1 ],
                                    "midpoints": [ 423.5, 329.5223388671875, 717.5, 329.5223388671875 ],
                                    "order": 1,
                                    "source": [ "obj-19", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-24", 0 ],
                                    "source": [ "obj-19", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-26", 0 ],
                                    "midpoints": [ 423.5, 328.8297119140625, 764.5, 328.8297119140625 ],
                                    "order": 0,
                                    "source": [ "obj-19", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-3", 0 ],
                                    "source": [ "obj-2", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-1", 0 ],
                                    "source": [ "obj-23", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-118", 0 ],
                                    "source": [ "obj-24", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-27", 0 ],
                                    "source": [ "obj-26", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-23", 0 ],
                                    "source": [ "obj-3", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-117", 0 ],
                                    "midpoints": [ 294.3000044822693, 402.0, 59.49999278783798, 402.0 ],
                                    "source": [ "obj-4", 1 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-6", 0 ],
                                    "source": [ "obj-4", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-5", 0 ],
                                    "source": [ "obj-6", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-117", 0 ],
                                    "midpoints": [ 320.5, 402.0, 59.49999278783798, 402.0 ],
                                    "source": [ "obj-9", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 472.0, 714.0, 151.99999296665192, 22.0 ],
                    "text": "p record"
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "bgcolor": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 0.0 ],
                    "border": 5,
                    "bordercolor": [ 0.6313725490196078, 0.09019607843137255, 0.09019607843137255, 1.0 ],
                    "id": "obj-116",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 634.0, 695.0, 38.0, 41.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1178.0, 382.0, 235.2000035047531, 175.20000261068344 ],
                    "proportion": 0.5
                }
            },
            {
                "box": {
                    "angle": 270.0,
                    "bgcolor": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 0.0 ],
                    "border": 5,
                    "bordercolor": [ 0.0196078431372549, 0.3215686274509804, 0.12156862745098039, 1.0 ],
                    "id": "obj-115",
                    "maxclass": "panel",
                    "mode": 0,
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1815.0, 240.0, 128.0, 128.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1425.0, 230.0, 235.2000035047531, 326.400004863739 ],
                    "proportion": 0.5
                }
            },
            {
                "box": {
                    "fontsize": 24.0,
                    "id": "obj-114",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1815.0, 379.0, 240.0, 87.0 ],
                    "presentation": 1,
                    "presentation_linecount": 3,
                    "presentation_rect": [ 1429.0, 235.0, 240.0, 87.0 ],
                    "text": "QUAD Record Label \nTrack \nPlayback for Set 2"
                }
            },
            {
                "box": {
                    "id": "obj-113",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1154.0, 20.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1075.0, 16.0, 150.0, 20.0 ],
                    "text": "Scene Selection"
                }
            },
            {
                "box": {
                    "fontsize": 24.0,
                    "id": "obj-110",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 418.0, 812.0, 57.600000858306885, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1125.0, 403.0, 44.00000065565109, 33.0 ],
                    "text": "BR"
                }
            },
            {
                "box": {
                    "fontsize": 24.0,
                    "id": "obj-111",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 385.0, 812.0, 57.600000858306885, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1075.0, 403.0, 44.00000065565109, 33.0 ],
                    "text": "BL"
                }
            },
            {
                "box": {
                    "fontsize": 24.0,
                    "id": "obj-109",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 342.0, 807.0, 57.600000858306885, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1125.0, 234.0, 44.00000065565109, 33.0 ],
                    "text": "FR"
                }
            },
            {
                "box": {
                    "fontsize": 24.0,
                    "id": "obj-108",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 308.0, 807.0, 57.600000858306885, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1075.0, 234.0, 44.00000065565109, 33.0 ],
                    "text": "FL"
                }
            },
            {
                "box": {
                    "channels": 4,
                    "id": "obj-106",
                    "lastchannelcount": 0,
                    "maxclass": "live.gain~",
                    "numinlets": 4,
                    "numoutlets": 7,
                    "outlettype": [ "signal", "signal", "signal", "signal", "", "float", "list" ],
                    "parameter_enable": 1,
                    "patching_rect": [ 1815.0, 601.0, 208.0, 162.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1430.0, 383.0, 196.0, 163.0 ],
                    "saved_attribute_attributes": {
                        "valueof": {
                            "parameter_longname": "QUAD TRACK PLAYBACK",
                            "parameter_mmax": 6.0,
                            "parameter_mmin": -70.0,
                            "parameter_modmode": 3,
                            "parameter_shortname": "QUAD TRACK PLAYBACK",
                            "parameter_type": 0,
                            "parameter_unitstyle": 4
                        }
                    },
                    "thickness": 15,
                    "varname": "live.gain~"
                }
            },
            {
                "box": {
                    "id": "obj-105",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1815.0, 510.0, 29.5, 22.0 ],
                    "text": "0"
                }
            },
            {
                "box": {
                    "id": "obj-102",
                    "maxclass": "textbutton",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1815.0, 478.0, 100.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1429.0, 327.0, 100.0, 20.0 ],
                    "text": "Stop Playback",
                    "texton": "Stopping..."
                }
            },
            {
                "box": {
                    "hiderwff": 1,
                    "id": "obj-9",
                    "maxclass": "playbar",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "int" ],
                    "patching_rect": [ 1860.0, 509.0, 196.0, 19.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1429.0, 356.0, 196.0, 19.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-99",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 0,
                    "patching_rect": [ 1815.0, 786.0, 102.0, 22.0 ],
                    "text": "dac~ 25 26 27 28"
                }
            },
            {
                "box": {
                    "id": "obj-98",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [ "signal", "signal", "signal", "signal", "bang" ],
                    "patching_rect": [ 1815.0, 556.0, 271.0, 22.0 ],
                    "text": "sfplay~ 4 @audiofile Belonging_Quad_Track.wav"
                }
            },
            {
                "box": {
                    "id": "obj-96",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 419.0, 598.0, 138.0, 47.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 1184.0, 230.0, 193.0, 33.0 ],
                    "text": "Headphone Monitor (pre-panning) OUT CH 5"
                }
            },
            {
                "box": {
                    "id": "obj-87",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1258.0, 545.0, 70.0, 22.0 ],
                    "text": "loadmess 1"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 48.0, 826.0, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "data": {
                        "global": {
                            "glide": 2.4245159068724056
                        },
                        "scenes": {
                            "ensemble1": {
                                "rich_headset": {
                                    "level": -70,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 0.3700787401574803,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ -3.443, 2.635 ],
                                    "assign": "drift"
                                },
                                "rich_bowls": {
                                    "level": 0,
                                    "spread": 0.7583259966519934,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 0.5275590551181102,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ 1.977, -0.687 ],
                                    "assign": "hop"
                                },
                                "tia_gtr": {
                                    "level": -70,
                                    "spread": 0.1408642817285635,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ 2.663, 2.896 ],
                                    "assign": "orbit"
                                },
                                "tia_vox": {
                                    "level": -70,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ 3.332, 2.264 ],
                                    "assign": "pulse"
                                },
                                "samiul_gtr": {
                                    "level": -8.8,
                                    "spread": 0.01,
                                    "width": 0.47244094488188976,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ -1.94, 0.668 ],
                                    "assign": "drift"
                                },
                                "bilal_gtr": {
                                    "level": -70,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ 3.499, 3.452 ],
                                    "assign": "pulse"
                                },
                                "bilal_tape": {
                                    "level": -70,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ -0.232, 2.859 ]
                                },
                                "michael_piano": {
                                    "level": -70,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "drift": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "perimeter": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ 1.55, 2.32 ],
                                    "loop": {
                                        "dur": 1.279,
                                        "pts": [
                                            [ 0.106, 1.995, -0.148 ],
                                            [ 0.145, 1.828, -0.167 ],
                                            [ 0.182, 1.735, -0.167 ],
                                            [ 0.217, 1.643, -0.167 ],
                                            [ 0.249, 1.568, -0.167 ],
                                            [ 0.282, 1.513, -0.167 ],
                                            [ 0.318, 1.457, -0.186 ],
                                            [ 0.349, 1.364, -0.223 ],
                                            [ 0.381, 1.253, -0.278 ],
                                            [ 0.418, 1.141, -0.316 ],
                                            [ 0.449, 1.049, -0.353 ],
                                            [ 0.484, 1.03, -0.371 ],
                                            [ 0.517, 0.845, -0.427 ],
                                            [ 0.55, 0.77, -0.445 ],
                                            [ 0.583, 0.715, -0.464 ],
                                            [ 0.617, 0.659, -0.483 ],
                                            [ 0.648, 0.659, -0.483 ],
                                            [ 0.682, 0.622, -0.483 ],
                                            [ 0.715, 0.585, -0.483 ],
                                            [ 0.749, 0.585, -0.483 ],
                                            [ 0.782, 0.529, -0.445 ],
                                            [ 0.816, 0.492, -0.427 ],
                                            [ 0.851, 0.455, -0.39 ],
                                            [ 0.885, 0.38, -0.371 ],
                                            [ 0.918, 0.306, -0.371 ],
                                            [ 0.95, 0.176, -0.371 ],
                                            [ 0.982, 0.028, -0.39 ],
                                            [ 1.016, -0.102, -0.39 ],
                                            [ 1.051, -0.121, -0.39 ],
                                            [ 1.066, -0.251, -0.39 ],
                                            [ 1.096, -0.306, -0.39 ],
                                            [ 1.133, -0.399, -0.39 ],
                                            [ 1.167, -0.473, -0.39 ],
                                            [ 1.202, -0.529, -0.371 ],
                                            [ 1.244, -0.566, -0.371 ],
                                            [ 1.279, -0.585, -0.371 ]
                                        ]
                                    }
                                }
                            },
                            "ensemble2": {
                                "keisha_piano": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "martin_cl": {
                                    "level": -55.1,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "martin_bcl": {
                                    "level": -59.5,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "loop": {
                                        "dur": 0.58,
                                        "pts": [
                                            [ 0, -1.335, 0.459 ],
                                            [ 0.038, -1.372, 0.348 ],
                                            [ 0.07, -1.372, 0.181 ],
                                            [ 0.085, -1.372, 0.125 ],
                                            [ 0.115, -1.372, 0.014 ],
                                            [ 0.153, -1.354, -0.153 ],
                                            [ 0.188, -1.317, -0.264 ],
                                            [ 0.23, -1.28, -0.413 ],
                                            [ 0.263, -1.261, -0.506 ],
                                            [ 0.297, -1.242, -0.617 ],
                                            [ 0.33, -1.224, -0.747 ],
                                            [ 0.362, -1.168, -0.84 ],
                                            [ 0.397, -1.15, -0.933 ],
                                            [ 0.431, -1.094, -0.988 ],
                                            [ 0.463, -1.057, -1.044 ],
                                            [ 0.464, -3.658, -3.658, 1 ],
                                            [ 0.498, -3.658, -3.658 ],
                                            [ 0.531, -3.658, -3.658 ],
                                            [ 0.565, -3.658, -3.658 ],
                                            [ 0.58, -3.658, -3.658 ]
                                        ]
                                    }
                                },
                                "olive_keys": {
                                    "level": -47.4,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "olive_vox": {
                                    "level": -49.1,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "dhaivat_kit": {
                                    "level": -11,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ 2.329, 0.742 ]
                                },
                                "dhaivat_tabla": {
                                    "level": -55.1,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "loop": {
                                        "dur": 1.271,
                                        "pts": [
                                            [ 0, 1.426, 1.781 ],
                                            [ 0.043, 1.314, 1.726 ],
                                            [ 0.075, 1.296, 1.726 ],
                                            [ 0.109, 1.222, 1.689 ],
                                            [ 0.146, 1.147, 1.67 ],
                                            [ 0.178, 1.129, 1.652 ],
                                            [ 0.218, 1.11, 1.652 ],
                                            [ 0.219, -3.658, 3.656, 1 ],
                                            [ 0.22, 2.948, 3.658, 1 ],
                                            [ 0.257, 2.948, 3.658 ],
                                            [ 0.285, 2.966, 3.658 ],
                                            [ 0.324, 3.022, 3.658 ],
                                            [ 0.359, 3.022, 3.658 ],
                                            [ 0.393, 3.022, 3.658 ],
                                            [ 0.424, 3.041, 3.658 ],
                                            [ 0.456, 3.041, 3.658 ],
                                            [ 0.474, 3.059, 3.658 ],
                                            [ 0.49, 3.059, 3.658 ],
                                            [ 0.522, 3.078, 3.638 ],
                                            [ 0.558, 3.078, 3.619 ],
                                            [ 0.592, 3.096, 3.582 ],
                                            [ 0.624, 3.115, 3.526 ],
                                            [ 0.658, 3.133, 3.489 ],
                                            [ 0.694, 3.152, 3.433 ],
                                            [ 0.73, 3.17, 3.396 ],
                                            [ 0.774, 3.189, 3.341 ],
                                            [ 0.81, 3.189, 3.322 ],
                                            [ 0.84, 3.208, 3.303 ],
                                            [ 0.874, 3.226, 3.248 ],
                                            [ 0.909, 3.245, 3.155 ],
                                            [ 0.91, 3.653, -3.658, 1 ],
                                            [ 0.926, 3.597, -3.658 ],
                                            [ 0.965, 3.17, -3.658 ],
                                            [ 0.998, 2.781, -3.658 ],
                                            [ 1.032, 2.632, -3.658 ],
                                            [ 1.066, 2.539, -3.658 ],
                                            [ 1.099, 2.484, -3.658 ],
                                            [ 1.133, 2.447, -3.658 ],
                                            [ 1.166, 2.447, -3.658 ],
                                            [ 1.198, 2.447, -3.658 ],
                                            [ 1.233, 2.428, -3.658 ],
                                            [ 1.271, 2.409, -3.658 ]
                                        ]
                                    }
                                },
                                "yuval_vox": {
                                    "level": -52.9,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "hop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "pulse": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "swarm": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                }
                            },
                            "switchemups1": {
                                "in3": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "in15": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "dhaivat_kit": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "martin_bcl": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "bilal_gtr": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "sway": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "in1": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    },
                                    "home": [ -0.213, 1.763 ]
                                },
                                "bilal_tape": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "orbit": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        },
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "in5": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "in6": {
                                    "level": 0,
                                    "spread": 0.01,
                                    "width": 1,
                                    "modes": {
                                        "manual": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                }
                            },
                            "switchemups2": {                            }
                        }
                    },
                    "id": "obj-49",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [ "dictionary", "", "", "", "" ],
                    "patching_rect": [ 48.0, 867.0, 166.0, 22.0 ],
                    "saved_object_attributes": {
                        "embed": 1,
                        "legacy": 0,
                        "parameter_enable": 0,
                        "parameter_mappable": 0
                    },
                    "text": "dict dbap_params @embed 1"
                }
            },
            {
                "box": {
                    "id": "obj-46",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 21.0, 114.0, 70.0, 22.0 ],
                    "text": "loadmess 0"
                }
            },
            {
                "box": {
                    "id": "obj-43",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 21.0, 147.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1090.0, 193.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-41",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 21.0, 177.0, 29.5, 22.0 ],
                    "text": "!= 1"
                }
            },
            {
                "box": {
                    "id": "obj-40",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 48.0, 149.0, 49.0, 47.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1102.0, 195.0, 131.20000195503235, 20.0 ],
                    "text": "MUTE EVERYTHING"
                }
            },
            {
                "box": {
                    "id": "obj-38",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 21.0, 210.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 279.0, 293.0, 59.0, 22.0 ],
                    "text": "gate~ 1 0"
                }
            },
            {
                "box": {
                    "id": "obj-34",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 201.0, 293.0, 59.0, 22.0 ],
                    "text": "gate~ 1 0"
                }
            },
            {
                "box": {
                    "id": "obj-27",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 124.0, 293.0, 59.0, 22.0 ],
                    "text": "gate~ 1 0"
                }
            },
            {
                "box": {
                    "id": "obj-26",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 45.0, 293.0, 59.0, 22.0 ],
                    "text": "gate~ 1 0"
                }
            },
            {
                "box": {
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 0,
                    "patching_rect": [ 45.0, 714.0, 253.0, 22.0 ],
                    "text": "dac~ 25 26 27 28"
                }
            },
            {
                "box": {
                    "id": "obj-297",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 0,
                    "patching_rect": [ 1388.0, 1109.0, 175.0, 22.0 ],
                    "text": "ctlout \"nanoKONTROL2 CTRL\""
                }
            },
            {
                "box": {
                    "id": "obj-250",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "int", "int" ],
                    "patching_rect": [ 1388.0, 1065.0, 67.0, 22.0 ],
                    "text": "unpack 0 0"
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 431.0, 715.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1129.0, 339.0, 30.4000004529953, 64.00000095367432 ]
                }
            },
            {
                "box": {
                    "id": "obj-30",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 392.0, 715.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1075.0, 339.0, 32.00000047683716, 64.00000095367432 ]
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 351.0, 715.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1129.0, 269.0, 30.4000004529953, 62.40000092983246 ]
                }
            },
            {
                "box": {
                    "id": "obj-28",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 311.0, 715.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1075.0, 269.0, 32.00000047683716, 62.40000092983246 ]
                }
            },
            {
                "box": {
                    "filename": "nk_screen.js",
                    "id": "obj-123",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1435.0, 917.0, 135.0, 103.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1.0, 610.0, 1069.0, 336.0 ],
                    "textfile": {
                        "filename": "nk_screen.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-104",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1418.0, 823.0, 125.0, 22.0 ],
                    "text": "send to_vbap_display"
                }
            },
            {
                "box": {
                    "id": "obj-95",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1354.0, 357.0, 125.0, 22.0 ],
                    "text": "send to_vbap_display"
                }
            },
            {
                "box": {
                    "id": "obj-94",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 969.0, 421.0, 137.0, 22.0 ],
                    "text": "receive to_vbap_display"
                }
            },
            {
                "box": {
                    "id": "obj-85",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1348.0, 823.0, 54.0, 22.0 ],
                    "text": "pack 0 0"
                }
            },
            {
                "box": {
                    "id": "obj-84",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "int", "int" ],
                    "patching_rect": [ 1348.0, 786.0, 40.0, 22.0 ],
                    "text": "ctlin"
                }
            },
            {
                "box": {
                    "filename": "dbap_nk.js",
                    "id": "obj-83",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 1324.0, 872.0, 83.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 dbap_nk.js",
                    "textfile": {
                        "filename": "dbap_nk.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-81",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1452.0, 264.0, 137.0, 22.0 ],
                    "text": "receive to_dbap_control"
                }
            },
            {
                "box": {
                    "id": "obj-80",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1258.0, 938.0, 124.0, 22.0 ],
                    "text": "send to_dbap_control"
                }
            },
            {
                "box": {
                    "id": "obj-78",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1331.0, 704.0, 151.0, 22.0 ],
                    "text": "receive from_dbap_control"
                }
            },
            {
                "box": {
                    "id": "obj-77",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1209.0, 357.0, 138.0, 22.0 ],
                    "text": "send from_dbap_control"
                }
            },
            {
                "box": {
                    "id": "obj-76",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1284.0, 580.0, 190.0, 33.0 ],
                    "text": "Enable Keyboard input (must be on during the show)"
                }
            },
            {
                "box": {
                    "id": "obj-74",
                    "maxclass": "toggle",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1258.0, 580.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-72",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1258.0, 704.0, 52.0, 22.0 ],
                    "text": "gate 1 0"
                }
            },
            {
                "box": {
                    "id": "obj-71",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1291.0, 654.0, 75.0, 22.0 ],
                    "text": "prepend key"
                }
            },
            {
                "box": {
                    "id": "obj-70",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 4,
                    "outlettype": [ "int", "int", "int", "int" ],
                    "patching_rect": [ 1291.0, 622.0, 50.5, 22.0 ],
                    "text": "key"
                }
            },
            {
                "box": {
                    "filename": "dbap_view.js",
                    "id": "obj-69",
                    "maxclass": "v8ui",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 969.0, 452.0, 261.0, 255.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1.0, 1.0, 1069.0, 605.0 ],
                    "textfile": {
                        "filename": "dbap_view.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "filename": "dbap_behave.js",
                    "id": "obj-67",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "", "", "" ],
                    "patching_rect": [ 1258.0, 748.0, 151.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 dbap_behave.js",
                    "textfile": {
                        "filename": "dbap_behave.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            },
            {
                "box": {
                    "id": "obj-66",
                    "maxclass": "newobj",
                    "numinlets": 0,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patcher": {
                        "fileversion": 1,
                        "appversion": {
                            "major": 9,
                            "minor": 1,
                            "revision": 2,
                            "architecture": "x64",
                            "modernui": 1
                        },
                        "classnamespace": "box",
                        "rect": [ 0.0, 0.0, 1000.0, 780.0 ],
                        "boxes": [
                            {
                                "box": {
                                    "id": "obj-57",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 466.0, 133.0, 64.0, 22.0 ],
                                    "text": "calibrate 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-56",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 440.0, 100.0, 64.0, 22.0 ],
                                    "text": "calibrate 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-45",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 470.0, 417.0, 105.0, 22.0 ],
                                    "text": "width samiul_gtr 1"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-43",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 478.0, 306.0, 101.0, 22.0 ],
                                    "text": "slew samiul_gtr 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-41",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 448.0, 182.0, 111.0, 22.0 ],
                                    "text": "pos samiul_gtr 2 -3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-39",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 391.0, 251.0, 107.0, 22.0 ],
                                    "text": "pos samiul_gtr 0 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-36",
                                    "linecount": 3,
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 307.0, 148.0, 67.0, 49.0 ],
                                    "text": "pos samiul_gtr -2 3"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-34",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 182.0, 175.0, 105.0, 22.0 ],
                                    "text": "width samiul_gtr 0"
                                }
                            },
                            {
                                "box": {
                                    "id": "obj-12",
                                    "maxclass": "message",
                                    "numinlets": 2,
                                    "numoutlets": 1,
                                    "outlettype": [ "" ],
                                    "patching_rect": [ 50.0, 175.0, 111.0, 22.0 ],
                                    "text": "pos samiul_gtr 0 -2"
                                }
                            },
                            {
                                "box": {
                                    "comment": "",
                                    "id": "obj-65",
                                    "index": 1,
                                    "maxclass": "outlet",
                                    "numinlets": 1,
                                    "numoutlets": 0,
                                    "patching_rect": [ 353.1110839999999, 499.0, 30.0, 30.0 ]
                                }
                            }
                        ],
                        "lines": [
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-12", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-34", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-36", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-39", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-41", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-43", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-45", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-56", 0 ]
                                }
                            },
                            {
                                "patchline": {
                                    "destination": [ "obj-65", 0 ],
                                    "source": [ "obj-57", 0 ]
                                }
                            }
                        ]
                    },
                    "patching_rect": [ 1101.0, 178.0, 135.0, 22.0 ],
                    "text": "p testing_ctr_messages"
                }
            },
            {
                "box": {
                    "id": "obj-54",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1069.0, 271.0, 148.0, 22.0 ],
                    "text": "loadroom dbap_room.json"
                }
            },
            {
                "box": {
                    "id": "obj-52",
                    "maxclass": "newobj",
                    "numinlets": 24,
                    "numoutlets": 6,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 119.0, 191.0, 505.0, 22.0 ],
                    "text": "gen~ @gen dbap_core"
                }
            },
            {
                "box": {
                    "format": 6,
                    "id": "obj-50",
                    "maxclass": "flonum",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "", "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1539.0, 83.0, 50.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "int" ],
                    "patching_rect": [ 1539.0, 51.0, 77.0, 22.0 ],
                    "text": "adstatus cpu"
                }
            },
            {
                "box": {
                    "id": "obj-47",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1539.0, 21.0, 119.0, 22.0 ],
                    "text": "metro 500 @active 1"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1346.0, 57.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1097.0, 92.0, 150.0, 20.0 ],
                    "text": "Switchemups 1"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1346.0, 33.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1097.0, 66.0, 150.0, 20.0 ],
                    "text": "Ensemble 2"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1346.0, 9.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1097.0, 41.0, 150.0, 20.0 ],
                    "text": "Ensemble 1"
                }
            },
            {
                "box": {
                    "disabled": [ 0, 0, 0, 0, 0, 0 ],
                    "id": "obj-19",
                    "itemtype": 0,
                    "maxclass": "radiogroup",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "offset": 23,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 1325.0, 9.0, 18.0, 140.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1075.0, 44.0, 18.0, 140.0 ],
                    "size": 6,
                    "value": 0
                }
            },
            {
                "box": {
                    "id": "obj-18",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 3,
                    "outlettype": [ "int", "bang", "bang" ],
                    "patching_rect": [ 1057.0, 21.0, 42.0, 22.0 ],
                    "text": "t 0 b b"
                }
            },
            {
                "box": {
                    "id": "obj-17",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1057.0, -18.0, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 24,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 119.0, 113.0, 379.0, 22.0 ],
                    "text": "adc~ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24"
                }
            },
            {
                "box": {
                    "id": "obj-6",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 47.0, 937.0, 121.0, 22.0 ],
                    "text": "buffer~ dbap_spk 1 4"
                }
            },
            {
                "box": {
                    "id": "obj-5",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 2,
                    "outlettype": [ "float", "bang" ],
                    "patching_rect": [ 48.0, 905.0, 119.0, 22.0 ],
                    "text": "buffer~ dbap_pts 1 5"
                }
            },
            {
                "box": {
                    "id": "obj-4",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1080.0, 150.0, 169.0, 22.0 ],
                    "text": "loadscenes dbap_scenes.json"
                }
            },
            {
                "box": {
                    "filename": "dbap_control.js",
                    "id": "obj-2",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1209.0, 319.0, 106.0, 22.0 ],
                    "saved_object_attributes": {
                        "parameter_enable": 0
                    },
                    "text": "v8 dbap_control.js",
                    "textfile": {
                        "filename": "dbap_control.js",
                        "flags": 0,
                        "embed": 0,
                        "autowatch": 1
                    }
                }
            }
        ],
        "lines": [
            {
                "patchline": {
                    "destination": [ "obj-105", 0 ],
                    "source": [ "obj-102", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-20", 0 ],
                    "source": [ "obj-103", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-98", 0 ],
                    "source": [ "obj-105", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-99", 3 ],
                    "source": [ "obj-106", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-99", 2 ],
                    "source": [ "obj-106", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-99", 1 ],
                    "source": [ "obj-106", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-99", 0 ],
                    "source": [ "obj-106", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 22 ],
                    "midpoints": [ 838.5, 177.0, 593.3695652173913, 177.0 ],
                    "source": [ "obj-11", 22 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 21 ],
                    "midpoints": [ 825.5, 177.0, 572.2391304347826, 177.0 ],
                    "source": [ "obj-11", 21 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 20 ],
                    "midpoints": [ 812.5, 177.0, 551.108695652174, 177.0 ],
                    "source": [ "obj-11", 20 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 19 ],
                    "midpoints": [ 799.5, 177.0, 529.9782608695652, 177.0 ],
                    "source": [ "obj-11", 19 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 18 ],
                    "midpoints": [ 786.5, 177.0, 508.8478260869565, 177.0 ],
                    "source": [ "obj-11", 18 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 17 ],
                    "midpoints": [ 773.5, 177.0, 487.7173913043478, 177.0 ],
                    "source": [ "obj-11", 17 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 16 ],
                    "midpoints": [ 760.5, 177.0, 466.5869565217391, 177.0 ],
                    "source": [ "obj-11", 16 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 15 ],
                    "midpoints": [ 747.5, 177.0, 445.45652173913044, 177.0 ],
                    "source": [ "obj-11", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 14 ],
                    "midpoints": [ 734.5, 177.0, 424.32608695652175, 177.0 ],
                    "source": [ "obj-11", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 13 ],
                    "midpoints": [ 721.5, 177.0, 403.19565217391306, 177.0 ],
                    "source": [ "obj-11", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 12 ],
                    "midpoints": [ 708.5, 177.0, 382.0652173913044, 177.0 ],
                    "source": [ "obj-11", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 11 ],
                    "midpoints": [ 695.5, 177.0, 360.9347826086956, 177.0 ],
                    "source": [ "obj-11", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 10 ],
                    "midpoints": [ 682.5, 177.0, 339.804347826087, 177.0 ],
                    "source": [ "obj-11", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 9 ],
                    "midpoints": [ 669.5, 177.0, 318.67391304347825, 177.0 ],
                    "source": [ "obj-11", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 8 ],
                    "midpoints": [ 656.5, 177.0, 297.54347826086956, 177.0 ],
                    "source": [ "obj-11", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 7 ],
                    "midpoints": [ 643.5, 177.0, 276.4130434782609, 177.0 ],
                    "source": [ "obj-11", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 6 ],
                    "midpoints": [ 630.5, 177.0, 255.2826086956522, 177.0 ],
                    "source": [ "obj-11", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 5 ],
                    "midpoints": [ 617.5, 177.0, 234.1521739130435, 177.0 ],
                    "source": [ "obj-11", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 4 ],
                    "midpoints": [ 604.5, 177.0, 213.02173913043478, 177.0 ],
                    "source": [ "obj-11", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 3 ],
                    "midpoints": [ 591.5, 177.0, 191.8913043478261, 177.0 ],
                    "source": [ "obj-11", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 2 ],
                    "midpoints": [ 578.5, 177.0, 170.76086956521738, 177.0 ],
                    "source": [ "obj-11", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 1 ],
                    "midpoints": [ 565.5, 177.0, 149.6304347826087, 177.0 ],
                    "source": [ "obj-11", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 0 ],
                    "midpoints": [ 552.5, 177.0, 128.5, 177.0 ],
                    "source": [ "obj-11", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-83", 0 ],
                    "midpoints": [ 1444.5, 1030.2000007033348, 1587.776123046875, 1030.2000007033348, 1587.776123046875, 862.0, 1333.5, 862.0 ],
                    "source": [ "obj-123", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-148", 0 ],
                    "source": [ "obj-144", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-154", 0 ],
                    "midpoints": [ 547.999996483326, 744.5919434576026, 579.9686036194653, 744.5919434576026, 579.9686036194653, 759.0, 614.5, 759.0 ],
                    "source": [ "obj-144", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-157", 0 ],
                    "midpoints": [ 614.4999929666519, 752.6434326171875, 705.5, 752.6434326171875 ],
                    "source": [ "obj-144", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 4 ],
                    "source": [ "obj-147", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-151", 0 ],
                    "source": [ "obj-148", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-153", 0 ],
                    "source": [ "obj-151", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-153", 0 ],
                    "midpoints": [ 614.5, 809.7103594408982, 481.5, 809.7103594408982 ],
                    "order": 1,
                    "source": [ "obj-154", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-155", 0 ],
                    "midpoints": [ 614.5, 804.0, 705.5, 804.0 ],
                    "order": 0,
                    "source": [ "obj-154", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-155", 0 ],
                    "source": [ "obj-157", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 1334.5, 304.0, 1218.5, 304.0 ],
                    "source": [ "obj-161", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-168", 0 ],
                    "source": [ "obj-162", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-162", 0 ],
                    "source": [ "obj-167", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-161", 0 ],
                    "source": [ "obj-168", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-18", 0 ],
                    "source": [ "obj-17", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "midpoints": [ 1509.5, 737.0, 1267.5, 737.0 ],
                    "source": [ "obj-170", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-170", 0 ],
                    "source": [ "obj-171", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-19", 0 ],
                    "midpoints": [ 1066.5, 64.300537109375, 1138.1116943359375, 64.300537109375, 1138.1116943359375, -7.59197998046875, 1334.5, -7.59197998046875 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 1089.5, 110.5, 1089.5, 110.5 ],
                    "source": [ "obj-18", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-54", 0 ],
                    "source": [ "obj-18", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-179", 0 ],
                    "source": [ "obj-180", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-167", 0 ],
                    "source": [ "obj-19", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-77", 0 ],
                    "order": 1,
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-95", 0 ],
                    "midpoints": [ 1218.5, 349.0, 1363.5, 349.0 ],
                    "order": 0,
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-11", 0 ],
                    "source": [ "obj-20", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-297", 1 ],
                    "source": [ "obj-250", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-297", 0 ],
                    "source": [ "obj-250", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 0 ],
                    "midpoints": [ 54.5, 699.0, 481.5, 699.0 ],
                    "order": 0,
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 0 ],
                    "midpoints": [ 54.5, 318.0, 54.5, 318.0 ],
                    "order": 3,
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "midpoints": [ 54.5, 699.0, 320.5, 699.0 ],
                    "order": 2,
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 3 ],
                    "midpoints": [ 54.5, 462.0, 474.5, 462.0 ],
                    "order": 1,
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 1 ],
                    "midpoints": [ 133.5, 699.0, 514.749998241663, 699.0 ],
                    "order": 0,
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 1 ],
                    "midpoints": [ 133.5, 318.0, 132.5, 318.0 ],
                    "order": 3,
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "midpoints": [ 133.5, 699.0, 360.5, 699.0 ],
                    "order": 2,
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 5 ],
                    "midpoints": [ 133.5, 462.0, 505.8333333333333, 462.0 ],
                    "order": 1,
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-106", 0 ],
                    "midpoints": [ 2102.5, 589.5, 1824.5, 589.5 ],
                    "source": [ "obj-3", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 2 ],
                    "midpoints": [ 210.5, 699.0, 547.999996483326, 699.0 ],
                    "order": 0,
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 2 ],
                    "midpoints": [ 210.5, 318.0, 210.5, 318.0 ],
                    "order": 3,
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "midpoints": [ 210.5, 699.0, 401.5, 699.0 ],
                    "order": 2,
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 4 ],
                    "midpoints": [ 210.5, 462.0, 490.16666666666663, 462.0 ],
                    "order": 1,
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 3 ],
                    "midpoints": [ 288.5, 699.0, 581.2499947249889, 699.0 ],
                    "order": 0,
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 3 ],
                    "midpoints": [ 288.5, 318.0, 288.5, 318.0 ],
                    "order": 3,
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 0 ],
                    "midpoints": [ 288.5, 699.0, 440.5, 699.0 ],
                    "order": 2,
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 6 ],
                    "midpoints": [ 288.5, 462.0, 521.5, 462.0 ],
                    "order": 1,
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-103", 0 ],
                    "midpoints": [ 427.5, 442.23797607421875, 871.351806640625, 442.23797607421875, 871.351806640625, 29.252792358398438, 552.5, 29.252792358398438 ],
                    "order": 0,
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 0 ],
                    "order": 1,
                    "source": [ "obj-37", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "midpoints": [ 30.5, 279.0, 54.5, 279.0 ],
                    "order": 3,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "midpoints": [ 30.5, 279.0, 133.5, 279.0 ],
                    "order": 2,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 0 ],
                    "midpoints": [ 30.5, 279.0, 210.5, 279.0 ],
                    "order": 1,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "midpoints": [ 30.5, 279.0, 288.5, 279.0 ],
                    "order": 0,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 1089.5, 256.0, 1229.0, 256.0, 1229.0, 304.0, 1218.5, 304.0 ],
                    "source": [ "obj-4", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-38", 0 ],
                    "source": [ "obj-41", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-41", 0 ],
                    "source": [ "obj-43", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-43", 0 ],
                    "source": [ "obj-46", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-48", 0 ],
                    "source": [ "obj-47", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-50", 0 ],
                    "source": [ "obj-48", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 1 ],
                    "midpoints": [ 128.5, 254.28009033203125, 94.5, 254.28009033203125 ],
                    "source": [ "obj-52", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 1 ],
                    "midpoints": [ 225.7, 252.632080078125, 173.5, 252.632080078125 ],
                    "source": [ "obj-52", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 1 ],
                    "midpoints": [ 322.9, 251.92581176757812, 250.5, 251.92581176757812 ],
                    "source": [ "obj-52", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 1 ],
                    "midpoints": [ 420.1, 249.10064697265625, 328.5, 249.10064697265625 ],
                    "source": [ "obj-52", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 2 ],
                    "midpoints": [ 614.5, 270.0, 405.0, 270.0, 405.0, 462.0, 458.8333333333333, 462.0 ],
                    "source": [ "obj-52", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-97", 1 ],
                    "midpoints": [ 517.3, 270.0, 405.0, 270.0, 405.0, 462.0, 443.1666666666667, 462.0 ],
                    "source": [ "obj-52", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-49", 0 ],
                    "source": [ "obj-53", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 1078.5, 304.0, 1218.5, 304.0 ],
                    "source": [ "obj-54", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-37", 0 ],
                    "source": [ "obj-59", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 1110.5, 256.0, 1229.0, 256.0, 1229.0, 304.0, 1218.5, 304.0 ],
                    "source": [ "obj-66", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-104", 0 ],
                    "midpoints": [ 1399.5, 792.3159790039062, 1427.5, 792.3159790039062 ],
                    "order": 0,
                    "source": [ "obj-67", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 0 ],
                    "order": 1,
                    "source": [ "obj-67", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-80", 0 ],
                    "source": [ "obj-67", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-83", 0 ],
                    "source": [ "obj-67", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "midpoints": [ 978.5, 727.5, 1267.5, 727.5 ],
                    "source": [ "obj-69", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 23 ],
                    "midpoints": [ 488.5, 177.0, 614.5, 177.0 ],
                    "source": [ "obj-7", 23 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 22 ],
                    "midpoints": [ 472.8478260869565, 177.0, 593.3695652173913, 177.0 ],
                    "source": [ "obj-7", 22 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 21 ],
                    "midpoints": [ 457.19565217391306, 177.0, 572.2391304347826, 177.0 ],
                    "source": [ "obj-7", 21 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 20 ],
                    "midpoints": [ 441.54347826086956, 177.0, 551.108695652174, 177.0 ],
                    "source": [ "obj-7", 20 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 19 ],
                    "midpoints": [ 425.89130434782606, 177.0, 529.9782608695652, 177.0 ],
                    "source": [ "obj-7", 19 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 18 ],
                    "midpoints": [ 410.2391304347826, 177.0, 508.8478260869565, 177.0 ],
                    "source": [ "obj-7", 18 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 17 ],
                    "midpoints": [ 394.5869565217391, 177.0, 487.7173913043478, 177.0 ],
                    "source": [ "obj-7", 17 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 16 ],
                    "midpoints": [ 378.9347826086956, 177.0, 466.5869565217391, 177.0 ],
                    "source": [ "obj-7", 16 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 15 ],
                    "midpoints": [ 363.2826086956522, 177.0, 445.45652173913044, 177.0 ],
                    "source": [ "obj-7", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 14 ],
                    "midpoints": [ 347.6304347826087, 177.0, 424.32608695652175, 177.0 ],
                    "source": [ "obj-7", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 13 ],
                    "midpoints": [ 331.97826086956525, 177.0, 403.19565217391306, 177.0 ],
                    "source": [ "obj-7", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 12 ],
                    "midpoints": [ 316.32608695652175, 177.0, 382.0652173913044, 177.0 ],
                    "source": [ "obj-7", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 11 ],
                    "midpoints": [ 300.67391304347825, 177.0, 360.9347826086956, 177.0 ],
                    "source": [ "obj-7", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 10 ],
                    "midpoints": [ 285.02173913043475, 177.0, 339.804347826087, 177.0 ],
                    "source": [ "obj-7", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 9 ],
                    "midpoints": [ 269.3695652173913, 177.0, 318.67391304347825, 177.0 ],
                    "source": [ "obj-7", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 8 ],
                    "midpoints": [ 253.7173913043478, 177.0, 297.54347826086956, 177.0 ],
                    "source": [ "obj-7", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 7 ],
                    "midpoints": [ 238.06521739130434, 177.0, 276.4130434782609, 177.0 ],
                    "source": [ "obj-7", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 6 ],
                    "midpoints": [ 222.41304347826087, 177.0, 255.2826086956522, 177.0 ],
                    "source": [ "obj-7", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 5 ],
                    "midpoints": [ 206.76086956521738, 177.0, 234.1521739130435, 177.0 ],
                    "source": [ "obj-7", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 4 ],
                    "midpoints": [ 191.1086956521739, 177.0, 213.02173913043478, 177.0 ],
                    "source": [ "obj-7", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 3 ],
                    "midpoints": [ 175.45652173913044, 177.0, 191.8913043478261, 177.0 ],
                    "source": [ "obj-7", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 2 ],
                    "midpoints": [ 159.80434782608694, 177.0, 170.76086956521738, 177.0 ],
                    "source": [ "obj-7", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 1 ],
                    "midpoints": [ 144.15217391304347, 186.0, 149.6304347826087, 186.0 ],
                    "source": [ "obj-7", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 0 ],
                    "midpoints": [ 128.5, 138.0, 128.5, 138.0 ],
                    "source": [ "obj-7", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-71", 0 ],
                    "source": [ "obj-70", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 1 ],
                    "source": [ "obj-71", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "source": [ "obj-72", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-72", 0 ],
                    "source": [ "obj-74", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-13", 0 ],
                    "order": 1,
                    "source": [ "obj-78", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "midpoints": [ 1340.5, 737.0, 1267.5, 737.0 ],
                    "order": 0,
                    "source": [ "obj-78", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-1", 0 ],
                    "source": [ "obj-8", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 1461.5, 304.0, 1218.5, 304.0 ],
                    "source": [ "obj-81", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-123", 0 ],
                    "source": [ "obj-83", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-250", 0 ],
                    "source": [ "obj-83", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "midpoints": [ 1333.5, 896.0, 1245.0, 896.0, 1245.0, 736.87890625, 1267.5, 736.87890625 ],
                    "source": [ "obj-83", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-85", 1 ],
                    "source": [ "obj-84", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-85", 0 ],
                    "source": [ "obj-84", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-83", 0 ],
                    "source": [ "obj-85", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-74", 0 ],
                    "source": [ "obj-87", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-98", 0 ],
                    "source": [ "obj-9", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-69", 0 ],
                    "source": [ "obj-94", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-146", 0 ],
                    "source": [ "obj-97", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-149", 0 ],
                    "source": [ "obj-97", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-96", 0 ],
                    "source": [ "obj-97", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-106", 3 ],
                    "source": [ "obj-98", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-106", 2 ],
                    "source": [ "obj-98", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-106", 1 ],
                    "source": [ "obj-98", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-106", 0 ],
                    "source": [ "obj-98", 0 ]
                }
            }
        ],
        "parameters": {
            "obj-106": [ "QUAD TRACK PLAYBACK", "QUAD TRACK PLAYBACK", 0 ],
            "parameterbanks": {
                "0": {
                    "index": 0,
                    "name": "",
                    "parameters": [ "-", "-", "-", "-", "-", "-", "-", "-" ],
                    "buttons": [ "-", "-", "-", "-", "-", "-", "-", "-" ]
                }
            },
            "inherited_shortname": 1
        },
        "autosave": 0,
        "boxgroups": [
            {
                "boxes": [ "obj-160", "obj-159", "obj-158", "obj-19", "obj-25", "obj-24", "obj-23", "obj-113" ]
            },
            {
                "boxes": [ "obj-110", "obj-111", "obj-109", "obj-28", "obj-29", "obj-30", "obj-31", "obj-108" ]
            },
            {
                "boxes": [ "obj-115", "obj-114", "obj-9", "obj-102", "obj-105", "obj-98", "obj-106", "obj-99" ]
            },
            {
                "boxes": [ "obj-116", "obj-147", "obj-153", "obj-155" ]
            },
            {
                "boxes": [ "obj-149", "obj-146", "obj-96" ]
            }
        ]
    }
}