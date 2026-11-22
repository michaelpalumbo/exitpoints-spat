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
        "rect": [ -1646.0, 590.0, 1598.0, 954.0 ],
        "boxes": [
            {
                "box": {
                    "id": "obj-157",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 696.5, 477.5, 72.0, 22.0 ],
                    "text": "prepend set"
                }
            },
            {
                "box": {
                    "fontsize": 12.0,
                    "id": "obj-155",
                    "linecount": 3,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 696.5, 524.8000078201294, 165.0, 47.0 ],
                    "presentation": 1,
                    "presentation_linecount": 3,
                    "presentation_rect": [ 1039.2000154852867, 189.60000282526016, 208.00000309944153, 47.0 ],
                    "text": "recording to EP_78_Quad_Recording_11_21_2026_23_51_39.wav"
                }
            },
            {
                "box": {
                    "id": "obj-154",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 605.0, 502.4000074863434, 79.0, 22.0 ],
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
                    "patching_rect": [ 472.0000070333481, 549.6000081896782, 228.0, 29.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1039.2000154852867, 153.60000199079514, 151.20000225305557, 29.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-151",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 472.0000070333481, 512.8000076413155, 72.0, 22.0 ],
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
                    "patching_rect": [ 472.0000070333481, 484.000007212162, 91.0, 22.0 ],
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
                    "patching_rect": [ 605.0, 364.0, 152.80000227689743, 49.199993789196014 ],
                    "presentation": 1,
                    "presentation_rect": [ 1037.6000154614449, 96.8000014424324, 152.80000227689743, 49.199993789196014 ],
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
                                                    "text": "MacSSD:/Users/michaelpalumbo/exitpoints-spat/"
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
                    "patching_rect": [ 472.0000070333481, 444.0, 151.99999296665192, 22.0 ],
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
                    "patching_rect": [ 994.4000148177147, 529.0, 128.0, 128.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1024.000015258789, 48.800000727176666, 235.2000035047531, 273.6000040769577 ],
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
                    "patching_rect": [ 1088.8000162243843, 292.00000435113907, 128.0, 128.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1024.000015258789, 380.00000566244125, 235.2000035047531, 326.400004863739 ],
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
                    "patching_rect": [ 659.0, 609.0, 240.0, 87.0 ],
                    "presentation": 1,
                    "presentation_linecount": 3,
                    "presentation_rect": [ 1028.0000153183937, 384.5, 240.0, 87.0 ],
                    "text": "QUAD Record Label \nTrack \nPlayback for Set 2"
                }
            },
            {
                "box": {
                    "id": "obj-113",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 784.8000116944313, 14.400000214576721, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 793.2000060975552, 23.20000034570694, 150.0, 20.0 ],
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
                    "patching_rect": [ 689.0, 639.0, 240.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 839.600006788969, 553.6000082492828, 44.00000065565109, 33.0 ],
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
                    "patching_rect": [ 674.0, 624.0, 240.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 790.0000060498714, 553.6000082492828, 44.00000065565109, 33.0 ],
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
                    "patching_rect": [ 674.0, 624.0, 240.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 840.40000680089, 384.8000057339668, 44.00000065565109, 33.0 ],
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
                    "patching_rect": [ 659.0, 609.0, 240.0, 33.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 790.0000060498714, 384.8000057339668, 44.00000065565109, 33.0 ],
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
                    "patching_rect": [ 1213.0, 1318.0, 208.0, 162.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1028.8000153303146, 533.3000022172928, 196.0, 163.0 ],
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
                    "patching_rect": [ 1213.0, 1226.0, 29.5, 22.0 ],
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
                    "patching_rect": [ 1213.0, 1195.0, 100.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1028.0000153183937, 477.30000138282776, 100.0, 20.0 ],
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
                    "patching_rect": [ 1258.0, 1226.0, 196.0, 19.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 1028.0000153183937, 506.1000018119812, 196.0, 19.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-99",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 0,
                    "patching_rect": [ 1213.0, 1495.0, 113.5, 22.0 ],
                    "text": "dac~ 1 2 3 4"
                }
            },
            {
                "box": {
                    "id": "obj-98",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [ "signal", "signal", "signal", "signal", "bang" ],
                    "patching_rect": [ 1213.0, 1272.0, 271.0, 22.0 ],
                    "text": "sfplay~ 4 @audiofile Belonging_Quad_Track.wav"
                }
            },
            {
                "box": {
                    "id": "obj-96",
                    "linecount": 2,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1403.0, 620.0, 150.0, 47.0 ],
                    "presentation": 1,
                    "presentation_linecount": 2,
                    "presentation_rect": [ 897.2000076472759, 384.8000057339668, 111.0, 47.0 ],
                    "text": "Headphone Monitor (Out CH 5)\n"
                }
            },
            {
                "box": {
                    "id": "obj-90",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 508.0, 351.0, 45.0, 22.0 ],
                    "text": "dac~ 5"
                }
            },
            {
                "box": {
                    "id": "obj-87",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 31.0, 557.0, 70.0, 22.0 ],
                    "text": "loadmess 1"
                }
            },
            {
                "box": {
                    "id": "obj-86",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 468.5, 746.0, 150.0, 20.0 ],
                    "text": "Store Preset"
                }
            },
            {
                "box": {
                    "id": "obj-82",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 463.0, 706.0, 150.0, 20.0 ],
                    "text": "Load Preset"
                }
            },
            {
                "box": {
                    "id": "obj-75",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 440.0, 744.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-68",
                    "maxclass": "button",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 437.0, 704.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-64",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 199.0, 793.0, 211.0, 22.0 ],
                    "text": "saveparams dbap_settings_show.json"
                }
            },
            {
                "box": {
                    "id": "obj-62",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 200.0, 759.0, 209.0, 22.0 ],
                    "text": "loadparams dbap_settings_show.json"
                }
            },
            {
                "box": {
                    "id": "obj-53",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "bang" ],
                    "patching_rect": [ 1258.0, 703.0, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "obj-51",
                    "maxclass": "dict.view",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1258.0, 775.0, 100.0, 100.0 ]
                }
            },
            {
                "box": {
                    "data": {
                        "global": {                        },
                        "scenes": {
                            "ensemble1": {
                                "rich_headset": {
                                    "level": 0,
                                    "spread": 0.415531782111134,
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
                                        }
                                    },
                                    "assign": "orbit"
                                },
                                "rich_bowls": {
                                    "level": 0,
                                    "spread": 0.8043508136357386,
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
                                        }
                                    },
                                    "home": [ -2.592, -0.076 ],
                                    "assign": "orbit"
                                },
                                "tia_gtr": {
                                    "level": 0,
                                    "spread": 0.1471816600179249,
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
                                        }
                                    },
                                    "assign": "orbit"
                                },
                                "tia_vox": {
                                    "level": 0,
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
                                        }
                                    }
                                },
                                "samiul_gtr": {
                                    "level": 0,
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
                                        }
                                    },
                                    "assign": "orbit"
                                },
                                "bilal_gtr": {
                                    "level": 0,
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
                                        }
                                    }
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
                                        "loop": {
                                            "range": 1,
                                            "speed": 1,
                                            "accel": 1
                                        }
                                    }
                                },
                                "michael_piano": {
                                    "level": 0,
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
                                        }
                                    }
                                }
                            }
                        }
                    },
                    "id": "obj-49",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 5,
                    "outlettype": [ "dictionary", "", "", "", "" ],
                    "patching_rect": [ 1258.0, 744.0, 166.0, 22.0 ],
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
                    "patching_rect": [ 23.0, 157.0, 70.0, 22.0 ],
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
                    "patching_rect": [ 23.0, 190.0, 24.0, 24.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 790.0000060498714, 343.2000051140785, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-41",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "int" ],
                    "patching_rect": [ 23.0, 220.0, 29.5, 22.0 ],
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
                    "patching_rect": [ 50.0, 192.0, 49.0, 47.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 817.200006455183, 345.6000051498413, 131.20000195503235, 20.0 ],
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
                    "patching_rect": [ 23.0, 253.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-35",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 279.0, 364.0, 59.0, 22.0 ],
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
                    "patching_rect": [ 201.0, 364.0, 59.0, 22.0 ],
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
                    "patching_rect": [ 124.0, 364.0, 59.0, 22.0 ],
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
                    "patching_rect": [ 45.0, 364.0, 59.0, 22.0 ],
                    "text": "gate~ 1 0"
                }
            },
            {
                "box": {
                    "id": "obj-22",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 0,
                    "patching_rect": [ 45.0, 444.0, 252.25000000000006, 22.0 ],
                    "text": "dac~ 1 2 3 4"
                }
            },
            {
                "box": {
                    "id": "obj-15",
                    "linecount": 13,
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1214.5, 398.0, 150.0, 181.0 ],
                    "presentation": 1,
                    "presentation_linecount": 13,
                    "presentation_rect": [ 787.6000060141087, 138.4000020623207, 150.0, 181.0 ],
                    "text": "todo: have a checklist for each set: \n\n1. ensure DSP is on\n2. ensure the correct ensemble scene is selected\n3. start recording\n4. reset show parameters (button)\n5. ... \n6. END of set: stop the recording"
                }
            },
            {
                "box": {
                    "id": "obj-12",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 918.0, 440.0, 91.0, 22.0 ],
                    "text": "print @popup 1"
                }
            },
            {
                "box": {
                    "id": "obj-297",
                    "maxclass": "newobj",
                    "numinlets": 3,
                    "numoutlets": 0,
                    "patching_rect": [ 161.0, 1128.0, 175.0, 22.0 ],
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
                    "patching_rect": [ 161.0, 1084.0, 67.0, 22.0 ],
                    "text": "unpack 0 0"
                }
            },
            {
                "box": {
                    "id": "obj-32",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 530.8, 253.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 897.2000076472759, 436.0000064969063, 32.0, 70.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-31",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 431.0, 445.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 843.6000068485737, 489.6000072956085, 30.4000004529953, 64.00000095367432 ]
                }
            },
            {
                "box": {
                    "id": "obj-30",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 392.0, 445.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 790.0000060498714, 489.6000072956085, 32.00000047683716, 64.00000095367432 ]
                }
            },
            {
                "box": {
                    "id": "obj-29",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 351.0, 445.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 843.6000068485737, 419.2000062465668, 30.4000004529953, 62.40000092983246 ]
                }
            },
            {
                "box": {
                    "id": "obj-28",
                    "maxclass": "meter~",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "float" ],
                    "patching_rect": [ 311.0, 445.0, 32.0, 87.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 790.0000060498714, 419.2000062465668, 32.00000047683716, 62.40000092983246 ]
                }
            },
            {
                "box": {
                    "id": "obj-126",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 208.0, 69.0, 40.0, 22.0 ],
                    "text": "*~ 0.1"
                }
            },
            {
                "box": {
                    "id": "obj-125",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "outlettype": [ "signal" ],
                    "patching_rect": [ 208.0, 34.0, 44.0, 22.0 ],
                    "text": "noise~"
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
                    "patching_rect": [ 1107.0, 897.0, 603.0, 270.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 0.39999428391456604, 460.00000685453415, 767.2000114321709, 290.4000043272972 ],
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
                    "patching_rect": [ 208.0, 950.0, 125.0, 22.0 ],
                    "text": "send to_vbap_display"
                }
            },
            {
                "box": {
                    "id": "obj-95",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 1007.0, 345.0, 125.0, 22.0 ],
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
                    "patching_rect": [ 475.0, 777.0, 137.0, 22.0 ],
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
                    "patching_rect": [ 125.0, 851.0, 54.0, 22.0 ],
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
                    "patching_rect": [ 125.0, 814.0, 40.0, 22.0 ],
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
                    "patching_rect": [ 97.0, 891.0, 83.0, 22.0 ],
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
                    "patching_rect": [ 1083.0, 258.0, 137.0, 22.0 ],
                    "text": "receive to_dbap_control"
                }
            },
            {
                "box": {
                    "id": "obj-80",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 31.0, 957.0, 124.0, 22.0 ],
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
                    "patching_rect": [ 104.0, 723.0, 151.0, 22.0 ],
                    "text": "receive from_dbap_control"
                }
            },
            {
                "box": {
                    "id": "obj-77",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 840.0, 351.0, 138.0, 22.0 ],
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
                    "patching_rect": [ 57.0, 599.0, 190.0, 33.0 ],
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
                    "patching_rect": [ 31.0, 599.0, 24.0, 24.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-72",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 31.0, 723.0, 52.0, 22.0 ],
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
                    "patching_rect": [ 64.0, 673.0, 75.0, 22.0 ],
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
                    "patching_rect": [ 64.0, 641.0, 50.5, 22.0 ],
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
                    "patching_rect": [ 475.0, 887.0, 606.0, 561.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 0.39999428391456604, 0.800000011920929, 767.2000114321709, 456.0000067949295 ],
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
                    "patching_rect": [ 31.0, 767.0, 151.0, 22.0 ],
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
                    "patching_rect": [ 732.0, 172.0, 135.0, 22.0 ],
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
                    "patching_rect": [ 700.0, 265.0, 148.0, 22.0 ],
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
                    "patching_rect": [ 1230.0, 105.0, 50.0, 22.0 ]
                }
            },
            {
                "box": {
                    "id": "obj-48",
                    "maxclass": "newobj",
                    "numinlets": 2,
                    "numoutlets": 2,
                    "outlettype": [ "", "int" ],
                    "patching_rect": [ 1230.0, 73.0, 77.0, 22.0 ],
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
                    "patching_rect": [ 1230.0, 43.0, 119.0, 22.0 ],
                    "text": "metro 500 @active 1"
                }
            },
            {
                "box": {
                    "id": "obj-25",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 977.0, 121.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 814.8000064194202, 96.8000014424324, 150.0, 20.0 ],
                    "text": "Switchemups"
                }
            },
            {
                "box": {
                    "id": "obj-24",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 977.0, 94.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 814.8000064194202, 69.60000103712082, 150.0, 20.0 ],
                    "text": "Ensemble 2"
                }
            },
            {
                "box": {
                    "id": "obj-23",
                    "maxclass": "comment",
                    "numinlets": 1,
                    "numoutlets": 0,
                    "patching_rect": [ 977.0, 69.0, 150.0, 20.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 814.8000064194202, 44.80000066757202, 150.0, 20.0 ],
                    "text": "Ensemble 1"
                }
            },
            {
                "box": {
                    "bgcolor": [ 1.0, 0.11764705882352941, 0.11764705882352941, 1.0 ],
                    "bgcolor2": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 1.0 ],
                    "bgfillcolor_angle": 270.0,
                    "bgfillcolor_autogradient": 0.0,
                    "bgfillcolor_color": [ 1.0, 0.11764705882352941, 0.11764705882352941, 1.0 ],
                    "bgfillcolor_color1": [ 1.0, 0.11764705882352941, 0.11764705882352941, 1.0 ],
                    "bgfillcolor_color2": [ 0.172137149796092, 0.172137100044002, 0.172137113045018, 1.0 ],
                    "bgfillcolor_proportion": 0.5,
                    "bgfillcolor_type": "gradient",
                    "gradient": 1,
                    "id": "obj-21",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1173.0, 196.0, 111.0, 22.0 ],
                    "text": "todo: switchemups!"
                }
            },
            {
                "box": {
                    "id": "obj-20",
                    "maxclass": "newobj",
                    "numinlets": 4,
                    "numoutlets": 4,
                    "outlettype": [ "bang", "bang", "bang", "" ],
                    "patching_rect": [ 956.0, 148.0, 337.0, 22.0 ],
                    "text": "sel 0 1 2"
                }
            },
            {
                "box": {
                    "disabled": [ 0, 0, 0 ],
                    "id": "obj-19",
                    "itemtype": 0,
                    "maxclass": "radiogroup",
                    "numinlets": 1,
                    "numoutlets": 1,
                    "offset": 20,
                    "outlettype": [ "" ],
                    "parameter_enable": 0,
                    "patching_rect": [ 956.0, 73.0, 18.0, 62.0 ],
                    "presentation": 1,
                    "presentation_rect": [ 793.2000060975552, 48.800000727176666, 18.0, 62.0 ],
                    "size": 3,
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
                    "patching_rect": [ 688.5, 15.0, 42.0, 22.0 ],
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
                    "patching_rect": [ 688.5, -24.0, 58.0, 22.0 ],
                    "text": "loadbang"
                }
            },
            {
                "box": {
                    "id": "obj-16",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 1062.0, 196.0, 103.0, 22.0 ],
                    "text": "scene ensemble2"
                }
            },
            {
                "box": {
                    "id": "obj-14",
                    "maxclass": "message",
                    "numinlets": 2,
                    "numoutlets": 1,
                    "outlettype": [ "" ],
                    "patching_rect": [ 956.0, 196.0, 103.0, 22.0 ],
                    "text": "scene ensemble1"
                }
            },
            {
                "box": {
                    "id": "obj-7",
                    "maxclass": "newobj",
                    "numinlets": 1,
                    "numoutlets": 24,
                    "outlettype": [ "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal", "signal" ],
                    "patching_rect": [ 119.0, 152.0, 505.0, 22.0 ],
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
                    "patching_rect": [ 14.0, 66.0, 121.0, 22.0 ],
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
                    "patching_rect": [ 15.0, 34.0, 119.0, 22.0 ],
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
                    "patching_rect": [ 711.0, 144.0, 169.0, 22.0 ],
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
                    "patching_rect": [ 840.0, 313.0, 106.0, 22.0 ],
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
                    "destination": [ "obj-126", 0 ],
                    "source": [ "obj-125", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 2 ],
                    "source": [ "obj-126", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 965.5, 300.0, 849.5, 300.0 ],
                    "source": [ "obj-14", 0 ]
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
                    "midpoints": [ 548.000003516674, 474.5919434576026, 579.9686036194653, 474.5919434576026, 579.9686036194653, 489.0, 614.5, 489.0 ],
                    "source": [ "obj-144", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-157", 0 ],
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
                    "midpoints": [ 614.5, 539.7103594408982, 481.5000070333481, 539.7103594408982 ],
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
                    "midpoints": [ 1071.5, 300.0, 849.5, 300.0 ],
                    "source": [ "obj-16", 0 ]
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
                    "destination": [ "obj-19", 0 ],
                    "source": [ "obj-18", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-4", 0 ],
                    "midpoints": [ 721.0, 104.5, 720.5, 104.5 ],
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
                    "destination": [ "obj-20", 0 ],
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
                    "order": 0,
                    "source": [ "obj-2", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-14", 0 ],
                    "source": [ "obj-20", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-16", 0 ],
                    "source": [ "obj-20", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-21", 0 ],
                    "source": [ "obj-20", 2 ]
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
                    "midpoints": [ 54.5, 429.0, 481.5000070333481, 429.0 ],
                    "order": 0,
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 0 ],
                    "order": 2,
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-28", 0 ],
                    "midpoints": [ 54.5, 429.0, 320.5, 429.0 ],
                    "order": 1,
                    "source": [ "obj-26", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 1 ],
                    "midpoints": [ 133.5, 429.0, 514.7500052750111, 429.0 ],
                    "order": 0,
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 1 ],
                    "order": 2,
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-29", 0 ],
                    "midpoints": [ 133.5, 429.0, 360.5, 429.0 ],
                    "order": 1,
                    "source": [ "obj-27", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 2 ],
                    "midpoints": [ 210.5, 429.0, 548.000003516674, 429.0 ],
                    "order": 0,
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 2 ],
                    "order": 2,
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-30", 0 ],
                    "midpoints": [ 210.5, 429.0, 401.5, 429.0 ],
                    "order": 1,
                    "source": [ "obj-34", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-144", 3 ],
                    "midpoints": [ 288.5, 429.0, 581.250001758337, 429.0 ],
                    "order": 0,
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-22", 3 ],
                    "order": 2,
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-31", 0 ],
                    "midpoints": [ 288.5, 429.0, 440.5, 429.0 ],
                    "order": 1,
                    "source": [ "obj-35", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 0 ],
                    "midpoints": [ 32.5, 351.0, 54.5, 351.0 ],
                    "order": 3,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 0 ],
                    "midpoints": [ 32.5, 351.0, 133.5, 351.0 ],
                    "order": 2,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 0 ],
                    "midpoints": [ 32.5, 351.0, 210.5, 351.0 ],
                    "order": 1,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 0 ],
                    "midpoints": [ 32.5, 351.0, 288.5, 351.0 ],
                    "order": 0,
                    "source": [ "obj-38", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 720.5, 252.0, 858.0, 252.0, 858.0, 300.0, 849.5, 300.0 ],
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
                    "destination": [ "obj-51", 0 ],
                    "source": [ "obj-49", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-26", 1 ],
                    "midpoints": [ 128.5, 351.0, 94.5, 351.0 ],
                    "source": [ "obj-52", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-27", 1 ],
                    "midpoints": [ 225.7, 351.0, 173.5, 351.0 ],
                    "source": [ "obj-52", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-32", 0 ],
                    "midpoints": [ 517.3, 240.0, 540.3, 240.0 ],
                    "order": 0,
                    "source": [ "obj-52", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-34", 1 ],
                    "midpoints": [ 322.9, 351.0, 250.5, 351.0 ],
                    "source": [ "obj-52", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-35", 1 ],
                    "midpoints": [ 420.1, 351.0, 328.5, 351.0 ],
                    "source": [ "obj-52", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-90", 0 ],
                    "midpoints": [ 517.3, 216.0, 517.5, 216.0 ],
                    "order": 1,
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
                    "source": [ "obj-54", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "source": [ "obj-62", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "source": [ "obj-64", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
                    "midpoints": [ 741.5, 252.0, 858.0, 252.0, 858.0, 300.0, 849.5, 300.0 ],
                    "source": [ "obj-66", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-104", 0 ],
                    "midpoints": [ 172.5, 811.3159790039062, 217.5, 811.3159790039062 ],
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
                    "destination": [ "obj-62", 0 ],
                    "source": [ "obj-68", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "midpoints": [ 484.5, 1475.6639404296875, 18.0, 1475.6639404296875, 18.0, 754.9371337890625, 40.5, 754.9371337890625 ],
                    "source": [ "obj-69", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 23 ],
                    "source": [ "obj-7", 23 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 22 ],
                    "source": [ "obj-7", 22 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 21 ],
                    "source": [ "obj-7", 21 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 20 ],
                    "source": [ "obj-7", 20 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 19 ],
                    "source": [ "obj-7", 19 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 18 ],
                    "source": [ "obj-7", 18 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 17 ],
                    "source": [ "obj-7", 17 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 16 ],
                    "source": [ "obj-7", 16 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 15 ],
                    "source": [ "obj-7", 15 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 14 ],
                    "source": [ "obj-7", 14 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 13 ],
                    "source": [ "obj-7", 13 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 12 ],
                    "source": [ "obj-7", 12 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 11 ],
                    "source": [ "obj-7", 11 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 10 ],
                    "source": [ "obj-7", 10 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 9 ],
                    "source": [ "obj-7", 9 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 8 ],
                    "source": [ "obj-7", 8 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 7 ],
                    "source": [ "obj-7", 7 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 6 ],
                    "source": [ "obj-7", 6 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 5 ],
                    "source": [ "obj-7", 5 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 4 ],
                    "source": [ "obj-7", 4 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 3 ],
                    "source": [ "obj-7", 3 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 2 ],
                    "source": [ "obj-7", 2 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 1 ],
                    "source": [ "obj-7", 1 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-52", 0 ],
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
                    "destination": [ "obj-64", 0 ],
                    "source": [ "obj-75", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-67", 0 ],
                    "source": [ "obj-78", 0 ]
                }
            },
            {
                "patchline": {
                    "destination": [ "obj-2", 0 ],
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
                    "midpoints": [ 106.5, 915.0, 18.0, 915.0, 18.0, 755.87890625, 40.5, 755.87890625 ],
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
                "boxes": [ "obj-110", "obj-31", "obj-111", "obj-30", "obj-28", "obj-29", "obj-108", "obj-109" ]
            },
            {
                "boxes": [ "obj-32", "obj-96" ]
            },
            {
                "boxes": [ "obj-115", "obj-106", "obj-9", "obj-114", "obj-102" ]
            }
        ]
    }
}