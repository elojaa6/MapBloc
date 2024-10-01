import 'dart:convert';

class TrafficResponse {
    final List<Route> routes;
    final List<Waypoint> waypoints;
    final String code;
    final String uuid;

    TrafficResponse({
        required this.routes,
        required this.waypoints,
        required this.code,
        required this.uuid,
    });

    factory TrafficResponse.fromRawJson(String str) => TrafficResponse.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TrafficResponse.fromJson(Map<String, dynamic> json) => TrafficResponse(
        routes: List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code,
        "uuid": uuid,
    };
}

class Route {
    final String weightName;
    final double weight;
    final double duration;
    final double distance;
    final List<Leg> legs;
    final String geometry;

    Route({
        required this.weightName,
        required this.weight,
        required this.duration,
        required this.distance,
        required this.legs,
        required this.geometry,
    });

    factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"],
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        legs: List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        geometry: json["geometry"],
    );

    Map<String, dynamic> toJson() => {
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": List<dynamic>.from(legs.map((x) => x.toJson())),
        "geometry": geometry,
    };
}

class Leg {
    final List<dynamic> viaWaypoints;
    final List<Admin> admins;
    final double weight;
    final double duration;
    final List<Step> steps;
    final double distance;
    final String summary;

    Leg({
        required this.viaWaypoints,
        required this.admins,
        required this.weight,
        required this.duration,
        required this.steps,
        required this.distance,
        required this.summary,
    });

    factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        viaWaypoints: List<dynamic>.from(json["via_waypoints"].map((x) => x)),
        admins: List<Admin>.from(json["admins"].map((x) => Admin.fromJson(x))),
        weight: json["weight"]?.toDouble(),
        duration: json["duration"]?.toDouble(),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
        distance: json["distance"]?.toDouble(),
        summary: json["summary"],
    );

    Map<String, dynamic> toJson() => {
        "via_waypoints": List<dynamic>.from(viaWaypoints.map((x) => x)),
        "admins": List<dynamic>.from(admins.map((x) => x.toJson())),
        "weight": weight,
        "duration": duration,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
        "distance": distance,
        "summary": summary,
    };
}

class Admin {
    final String iso31661Alpha3;
    final String iso31661;

    Admin({
        required this.iso31661Alpha3,
        required this.iso31661,
    });

    factory Admin.fromRawJson(String str) => Admin.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
    );

    Map<String, dynamic> toJson() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
    };
}

class Step {
    final List<Intersection> intersections;
    final Maneuver maneuver;
    final String name;
    final double duration;
    final double distance;
    final String drivingSide;
    final double weight;
    final String mode;
    final String? ref;
    final String geometry;

    Step({
        required this.intersections,
        required this.maneuver,
        required this.name,
        required this.duration,
        required this.distance,
        required this.drivingSide,
        required this.weight,
        required this.mode,
        this.ref,
        required this.geometry,
    });

    factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        intersections: List<Intersection>.from(json["intersections"].map((x) => Intersection.fromJson(x))),
        maneuver: Maneuver.fromJson(json["maneuver"]),
        name: json["name"],
        duration: json["duration"]?.toDouble(),
        distance: json["distance"]?.toDouble(),
        drivingSide: json["driving_side"],
        weight: json["weight"]?.toDouble(),
        mode: json["mode"],
        ref: json["ref"],
        geometry: json["geometry"],
    );

    Map<String, dynamic> toJson() => {
        "intersections": List<dynamic>.from(intersections.map((x) => x.toJson())),
        "maneuver": maneuver.toJson(),
        "name": name,
        "duration": duration,
        "distance": distance,
        "driving_side": drivingSide,
        "weight": weight,
        "mode": mode,
        "ref": ref,
        "geometry": geometry,
    };
}

class Intersection {
    final MapboxStreetsV8? mapboxStreetsV8;
    final List<bool> entry;
    final List<int> bearings;
    final double? duration;
    final bool? trafficSignal;
    final int adminIndex;
    final int? out;
    final double? weight;
    final int geometryIndex;
    final List<double> location;
    final int? intersectionIn;
    final double? turnDuration;
    final double? turnWeight;
    final TollCollection? tollCollection;

    Intersection({
        this.mapboxStreetsV8,
        required this.entry,
        required this.bearings,
        this.duration,
        this.trafficSignal,
        required this.adminIndex,
        this.out,
        this.weight,
        required this.geometryIndex,
        required this.location,
        this.intersectionIn,
        this.turnDuration,
        this.turnWeight,
        this.tollCollection,
    });

    factory Intersection.fromRawJson(String str) => Intersection.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        mapboxStreetsV8: json["mapbox_streets_v8"] == null ? null : MapboxStreetsV8.fromJson(json["mapbox_streets_v8"]),
        entry: List<bool>.from(json["entry"].map((x) => x)),
        bearings: List<int>.from(json["bearings"].map((x) => x)),
        duration: json["duration"]?.toDouble(),
        trafficSignal: json["traffic_signal"],
        adminIndex: json["admin_index"],
        out: json["out"],
        weight: json["weight"]?.toDouble(),
        geometryIndex: json["geometry_index"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        intersectionIn: json["in"],
        turnDuration: json["turn_duration"]?.toDouble(),
        turnWeight: json["turn_weight"]?.toDouble(),
        tollCollection: json["toll_collection"] == null ? null : TollCollection.fromJson(json["toll_collection"]),
    );

    Map<String, dynamic> toJson() => {
        "mapbox_streets_v8": mapboxStreetsV8?.toJson(),
        "entry": List<dynamic>.from(entry.map((x) => x)),
        "bearings": List<dynamic>.from(bearings.map((x) => x)),
        "duration": duration,
        "traffic_signal": trafficSignal,
        "admin_index": adminIndex,
        "out": out,
        "weight": weight,
        "geometry_index": geometryIndex,
        "location": List<dynamic>.from(location.map((x) => x)),
        "in": intersectionIn,
        "turn_duration": turnDuration,
        "turn_weight": turnWeight,
        "toll_collection": tollCollection?.toJson(),
    };
}

class MapboxStreetsV8 {
    final Class mapboxStreetsV8Class;

    MapboxStreetsV8({
        required this.mapboxStreetsV8Class,
    });

    factory MapboxStreetsV8.fromRawJson(String str) => MapboxStreetsV8.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MapboxStreetsV8.fromJson(Map<String, dynamic> json) => MapboxStreetsV8(
        mapboxStreetsV8Class: classValues.map[json["class"]]!,
    );

    Map<String, dynamic> toJson() => {
        "class": classValues.reverse[mapboxStreetsV8Class],
    };
}

enum Class {
    prymary,
    street,
    tertiary
}

final classValues = EnumValues({
    "primary": Class.prymary,
    "street": Class.street,
    "tertiary": Class.tertiary
});

class TollCollection {
    final String name;
    final String type;

    TollCollection({
        required this.name,
        required this.type,
    });

    factory TollCollection.fromRawJson(String str) => TollCollection.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TollCollection.fromJson(Map<String, dynamic> json) => TollCollection(
        name: json["name"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
    };
}

class Maneuver {
    final String type;
    final String instruction;
    final int bearingAfter;
    final int bearingBefore;
    final List<double> location;
    final String? modifier;

    Maneuver({
        required this.type,
        required this.instruction,
        required this.bearingAfter,
        required this.bearingBefore,
        required this.location,
        this.modifier,
    });

    factory Maneuver.fromRawJson(String str) => Maneuver.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        type: json["type"],
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        modifier: json["modifier"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location": List<dynamic>.from(location.map((x) => x)),
        "modifier": modifier,
    };
}

class Waypoint {
    final double distance;
    final String name;
    final List<double> location;

    Waypoint({
        required this.distance,
        required this.name,
        required this.location,
    });

    factory Waypoint.fromRawJson(String str) => Waypoint.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location": List<dynamic>.from(location.map((x) => x)),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
