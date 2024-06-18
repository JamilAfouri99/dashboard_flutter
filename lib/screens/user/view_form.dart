import 'package:cached_network_image/cached_network_image.dart';
import 'package:qcarder/utils/configuration/image-constants.dart';
import 'package:qcarder/utils/configuration/theme.dart';
import 'package:qcarder/utils/helpers/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qcarder/utils/helpers/image_path_by_label.dart';
import 'package:qcarder/utils/helpers/index.dart';
import 'package:qcarder_api/api.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewForm extends StatefulWidget {
  final User user;
  const ViewForm({super.key, required this.user});

  @override
  State<ViewForm> createState() => _ViewFormState();
}

class _ViewFormState extends State<ViewForm> {
  String displayEmail = '';
  String displayPhone = '';
  @override
  void initState() {
    super.initState();
    displayEmail = widget.user.profile.emails.isEmpty
        ? widget.user.email
        : '${widget.user.profile.emails[0].email} ⦿ ${widget.user.profile.emails[0].label}';
    displayPhone = widget.user.profile.phoneNumbers.isEmpty
        ? ''
        : '${widget.user.profile.phoneNumbers[0].phoneNumber} ⦿ ${widget.user.profile.phoneNumbers[0].label}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 0),
                  margin: const EdgeInsets.only(top: 0),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.zero,
                    child: widget.user.profile.banner != null &&
                            widget.user.profile.banner!.isNotEmpty &&
                            widget.user.profile.banner!.contains('https')
                        ? CachedNetworkImage(
                            imageUrl: widget.user.profile.banner ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: AppColors.onError,
                            ),
                            alignment: Alignment.topCenter,
                          )
                        : Image.asset(
                            ImageConstants.banner,
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
                      ),
                    ),
                    child: InkWell(
                      splashColor: AppColors.noColor,
                      highlightColor: AppColors.noColor,
                      onTap: () => widget.user.avatar == null
                          ? null
                          : showDialog(
                              builder: (BuildContext context) => Center(
                                child: AlertDialog(
                                  backgroundColor: AppColors.noColor,
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    width: MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.width * 0.8,
                                    child: CachedNetworkImage(
                                      imageUrl: widget.user.avatar ?? '',
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                      errorWidget: (context, url, error) => const Icon(
                                        Icons.error,
                                        color: AppColors.onError,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              context: context,
                            ),
                      child: ClipOval(
                        child: widget.user.avatar != null &&
                                widget.user.avatar!.isNotEmpty &&
                                widget.user.avatar!.contains('https')
                            ? CachedNetworkImage(
                                height: 120,
                                width: 120,
                                imageUrl: widget.user.avatar ?? '',
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  color: AppColors.onError,
                                ),
                              )
                            : Image.asset(
                                ImageConstants.placeholderUser,
                                width: 80.0,
                                height: 80.0,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Text(
                  widget.user.profile.displayName ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: AppColors.darkPrimary),
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.light,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.shadow.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (widget.user.profile.title != null &&
                          widget.user.profile.title!.isNotEmpty)
                        ListTile(
                          leading: Icon(
                            Icons.work_outline,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          title: Text(
                            widget.user.profile.title ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      if (widget.user.profile.company != null &&
                          widget.user.profile.company!.isNotEmpty)
                        ListTile(
                          leading: Icon(
                            Icons.business,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          title: Text(
                            widget.user.profile.company ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      _emailsWidget(context),
                      _phonesWidget(context),
                      if (widget.user.profile.address != null &&
                          widget.user.profile.address!.isNotEmpty)
                        ListTile(
                          leading: Icon(
                            Icons.pin_drop_outlined,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          title: Text(
                            widget.user.profile.address ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      if (widget.user.profile.birthday != null)
                        ListTile(
                          leading: Icon(
                            Icons.cake_outlined,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          title: Text(
                            widget.user.profile.birthday != null
                                ? widget.user.profile.birthday!.ymd
                                : '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      if (widget.user.profile.notes != null &&
                          widget.user.profile.notes!.isNotEmpty)
                        ListTile(
                          leading: Icon(
                            Icons.view_headline_rounded,
                            color: Theme.of(context).colorScheme.shadow,
                          ),
                          title: Text(
                            widget.user.profile.notes ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: widget.user.profile.links.map((link) {
                return Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () async {
                      String url = link.link;
                      if (!url.startsWith('http://') && !url.startsWith('https://')) {
                        url = 'https://$url';
                      }
                      Uri uri = Uri.parse(url);

                      launchUrl(
                        uri,
                        mode: url.contains('qcarder')
                            ? LaunchMode.inAppWebView
                            : LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: SvgPicture.asset(
                          linkPathByLabel(link.label),
                          fit: BoxFit.cover,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  );
                });
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailsWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: Icon(
          Icons.mail_outline_outlined,
          color: Theme.of(context).colorScheme.shadow,
        ),
        // subtitle: Text(email.label),
        title: widget.user.profile.emails.isNotEmpty && widget.user.profile.emails.length > 1
            ? DropdownButton(
                icon: const Icon(Icons.more_vert_outlined),
                autofocus: true,
                value: displayEmail,
                isDense: false,
                onChanged: (_) {},
                items: widget.user.profile.emails.map((value) {
                  return DropdownMenuItem(
                    onTap: () => setState(() {
                      displayEmail = '${value.email} ⦿ ${value.label}';
                    }),
                    value: '${value.email} ⦿ ${value.label}',
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        '${value.email} ⦿ ${value.label}',
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  );
                }).toList(),
              )
            : Text(
                displayEmail,
                style: Theme.of(context).textTheme.bodySmall,
              ),
      ),
    );
  }

  Widget _phonesWidget(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ListTile(
        leading: Icon(
          Icons.phone_outlined,
          color: Theme.of(context).colorScheme.shadow,
        ),
        // subtitle: Text(phone.label),
        title: widget.user.profile.phoneNumbers.isNotEmpty &&
                widget.user.profile.phoneNumbers.length > 1
            ? DropdownButton<String>(
                onChanged: (_) {},
                value: displayPhone,
                items: widget.user.profile.phoneNumbers
                    .map<DropdownMenuItem<String>>((PhoneNumber value) {
                  return DropdownMenuItem<String>(
                    onTap: () => setState(() {
                      displayPhone = '${value.phoneNumber} ⦿ ${value.label}';
                    }),
                    value: '${value.phoneNumber} ⦿ ${value.label}',
                    child: Text('${value.phoneNumber} ⦿ ${value.label}',
                        style: Theme.of(context).textTheme.bodySmall),
                  );
                }).toList(),
              )
            : Text(
                displayPhone,
                style: Theme.of(context).textTheme.bodySmall,
              ),
      ),
    );
  }
}
