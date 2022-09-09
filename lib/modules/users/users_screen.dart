import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socialapp/layout/cubit.dart';
import 'package:socialapp/layout/states.dart';
class UserScreen extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state)=> Scaffold(
          body: GoogleMap(
            // myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,

            ),
            onMapCreated: (GoogleMapController controller) {
              SocialCubit.get(context).place!.complete(controller);
            },
          ),
       ),
    );
  }
}
