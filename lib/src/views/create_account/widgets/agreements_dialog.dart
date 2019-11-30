import 'package:epaisa_pos/src/utility/colors.dart';
import 'package:epaisa_pos/src/utility/multilanguage.dart';
import 'package:epaisa_pos/src/utility/remove_over_scroll_glow.dart';
import 'package:epaisa_pos/src/utility/screen_utils.dart';
import 'package:epaisa_pos/src/utility/tablet.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_border.dart';
import 'package:epaisa_pos/src/widgets/buttons/button_gradient2.dart';
import 'package:flutter/material.dart';

class AgreementDialog extends StatefulWidget {
  AgreementDialog({this.selectOption});
  final Function selectOption;
  @override
  _AgreementDialogState createState() => _AgreementDialogState();
}

List<String> texts = [
  'Last updated: May 10, 2019 | Ver. 1.3',
  'These General Terms of Service (General Terms) are a legal agreement between you (you, your) and ePaisa, Services (P) Limited (ePaisa, we, our or us) and govern your use of ePaisa’s services, including mobile applications, websites, software, hardware, and other products and services (collectively, the Services). If you are using the Services on behalf of a business, that business accepts these terms. By using any of the Services you agree to these General Terms and any policies referenced within (Policies), including terms that limit our liability (see Section 18) and require individual arbitration for any potential legal dispute (see Section 21). You also agree to any additional terms specific to Services you use (Additional Terms), such as those listed below, which become part of your agreement with us. You should read all of our terms carefully. ',
  'Payment Terms: These terms apply to all payments made through the Services.\nPoint of Sale Additional Terms of Service: These terms apply when you use ePaisa Point of Sale.\nMobile Wallet Terms of Service: These terms apply when you use any Third Party Wallets on ePaisa Point of Sale.\nValue Added Services (VAS) Terms of Service: These terms apply when you use and Value Added Services (VAS) on ePaisa Point of Sale.\nOnline Payment Gateway Terms of Service: These terms apply when you use Online payment gateway Service of ePaisa.\nMoney Transfer Terms of Service: These terms apply when you use Money Transfer service on ePaisa Point of Sale',
  '1. Privacy',
  'You agree to ePaisa’s Privacy Policy, which explains how we collect, use and protect the personal information you provide to us.',
  '2. ePaisa Account Registration',
  'You must create an account with us (a ePaisa Account) to use the Services. During registration we will ask you for information, including your name and other personal information. You must provide accurate and complete information in response to our questions,and keep that information current. You are fully responsible for all activity that occurs under your ePaisa Account, including for any actions taken by persons to whom you have granted access to the ePaisa Account. We reserve the right to suspend or terminate the ePaisa Account of any user who provides inaccurate, untrue, or incomplete information, or who fails to comply with the account registration requirements.',
  '3. Revisions, Disclosures and Notices',
  'We may amend the General Terms, any Additional Terms, or our Policies, at any time with notice that we deem to be reasonable in the circumstances, by posting the revised version on our website or communicating it to you through the Services (each a Revised Version). The Revised Version will be effective as of the time it is posted, but will not apply retroactively. Your continued use of the Services after the posting of a Revised Version constitutes your acceptance of such Revised Version. Any Dispute (as defined in Section 20) that arose before the changes will be governed by the General Terms, Additional Terms or Policies in place when the Dispute arose.'
      'You agree to ePaisa’s E-Sign Consent. We may provide disclosures and notices required by law and other information about your ePaisa Account to you electronically, by posting it on our website, pushing notifications through the Services, or by emailing it to the email address listed in your ePaisa Account. Electronic disclosures and notices have the same meaning and effect as if we had provided you with paper copies. Such disclosures and notices are considered received by you within twenty-four (24) hours of the time posted to our website, or within twenty-four (24) hours of the time emailed to you unless we receive notice that the email was not delivered. If you wish to withdraw your consent to receiving electronic communications, contact ePaisa Support. If we are not able to support your request, you may need to terminate your ePaisa Account. '
      '4. Restrictions',
  'You may not, nor may you permit any third party, directly or indirectly, to:',
  'Export the Services, which may be subject to export restrictions imposed by Indian law;',
  'Access or monitor any material or information on any ePaisa system using any manual process or robot, spider, scraper, or other automated means;',
  'Except to the extent that any restriction is expressly prohibited by law, violate the restrictions in any robot exclusion headers on any Service, work around, bypass, or circumvent any of the technical limitations of the Services, use any tool to enable features or functionalities that are otherwise disabled in the Services, or decompile, disassemble or otherwise reverse engineer the Services perform or attempt to perform any actions that would interfere with the proper working of the Services, prevent access to or use of the Services by our other customers, or impose an unreasonable or disproportionately large load on our infrastructure copy, reproduce, alter, modify, create derivative works, publicly display, republish, upload, post, transmit, resell or distribute in any way material, information or Services from ePaisa; use and benefit from the Services via a rental, lease, timesharing, service bureau or other arrangement; transfer any rights granted to you under these General Terms; use the Services in a way that distracts or prevents you from obeying traffic or safety laws; use the Services for the sale of firearms, firearm parts, ammunition, weapons or other devices designed to cause physical harm; use the Services for any illegal activity or goods or in any way that exposes you, other ePaisa users, our partners, or ePaisa to harm; or otherwise use the Services except as expressly allowed under these General Terms and applicable Additional Terms. If we reasonably suspect that your ePaisa Account has been used for an unauthorized, illegal, or criminal purpose, you give us express authorization to share information about you, your ePaisa Account, and any of your transactions with any and all law enforcement agencies.',
  '5. Compatible Mobile Devices and Third Party Carriers',
  'We do not warrant that the Services will be compatible with your mobile device or carrier. Your use of the Services may be subject to the terms of your agreements with your mobile device manufacturer or your carrier. You may not use a modified device to use the Services if the modification is contrary to the manufacturer software or hardware guidelines, including disabling hardware or software control sometimes referred to as jail broken.',
  '6. Your Content',
  'The Services may include functionality for uploading or providing photos, logos, products, loyalty programs, promotions, advertisements and other materials or information (Content).',
  'You grant us and our subsidiaries, affiliates, and successors a worldwide, non-exclusive, royalty-free, fully-paid, transferable, and sub-licensable right to use, reproduce, modify, adapt, publish, prepare derivative works of, distribute, publicly perform, and publicly display your Content throughout the world in any media in order to provide and promote the Services. You retain all rights in your Content, subject to the rights you granted to us in these General Terms. You may modify or remove your Content via your ePaisa Account or by terminating your ePaisa Account, but your Content may persist in historical, archived or cached copies and versions thereof available on or through the Services.',
  'You will not upload or provide Content or otherwise post, transmit, distribute, or disseminate through the Services any material that: (a) is false, misleading, unlawful, obscene, indecent, lewd, pornographic, defamatory, libelous, threatening, harassing, hateful, abusive, or inflammatory; (b) encourages conduct that would be considered a criminal offense or gives rise to civil liability; (c) breaches any duty toward or rights of any person or entity, including rights of publicity, privacy or trademark; (d) contains corrupted data or any other harmful, disruptive, or destructive files; (e) advertises products or services competitive with ePaisa or its partners, products and services, as determined by us in our sole discretion; or (f) in our sole judgment, is objectionable, restricts or inhibits any person or entity from using or enjoying any portion of the Services, or which may expose ePaisa, its affiliates or its customers to harm or liability of any nature.',
  'Although we have no obligation to monitor any Content, we have absolute discretion to remove Content at any time and for any reason without notice. You understand that by using the Services, you may be exposed to Content that is offensive, indecent, or objectionable. We take no responsibility and assume no liability for any Content, including any loss or damage to any of your Content.',
  '7. Copyright and Trademark Infringement',
  'We respect the copyright and trademark rights of others and ask you to do the same. We have adopted a Copyright &amp; Trademark Policy regarding claims that third party material infringes the copyrights or trademarks of others. We respond to all valid notices of such copyright and trademark infringement, and our policy is to suspend or terminate the access privileges of those who infringe the copyrights and trademarks of others.',
  '8. Security',
  'We have implemented technical and organisational measures designed to secure your personal information from accidental loss and from unauthorised access, use, alteration, or disclosure. However, we cannot guarantee that unauthorised third parties will never be able to defeat those measures or use your personal information for improper purposes. You provide your personal information at your own risk.',
  'You are responsible for safeguarding your password and for restricting access to the Services from your compatible mobile devices and computer(s). You will immediately notify us of any unauthorized use of your password or ePaisa Account or any other breach of security. Notwithstanding Sections 20 and 21, in the event of any dispute between two or more parties as to account ownership, we will be the sole arbiter of such dispute in our sole discretion. Our decision (which may include termination or suspension of any ePaisa Account subject to dispute) will be final and binding on all parties.',
  '9. Communications',
  'You consent to accept and receive communications from us, including e-mail, text messages, calls, and push notifications to the cellular telephone number you provide to us. These communications may be generated by automatic telephone dialing systems which will deliver prerecorded messages, including for the purposes of secondary authentication, receipts, reminders and other notifications. Standard message and data rates applied by your cell phone carrier may apply to the text messages we send you. You may opt-out of receiving communications by following the unsubscribe options we provide to you. You may also opt-out of text messages from ePaisa at any time choosing the opt out settings in the ePaisa ñ Point of Sale APP. You acknowledge that opting out of receiving communications may impact your use of the Services.',
  '10. Paid Services',
  'ePaisa offers some services to be paid for on a recurring basis (Subscription Plans) or on an as-used basis (A La Carte Services and, together with the Subscription Services, Paid Services). ePaisa has the right to change, delete, discontinue or impose conditions on Paid Services or any feature or aspect of a Paid Service. Subscription Services may subject you to recurring fees and/or terms. By signing up for a Subscription Service, including after any free trial period, you agree to pay us the subscription fee and any applicable taxes as set forth in your ePaisa Account settings or as otherwise agreed in writing (Subscription Fee). A La Carte Services may subject you to fees charged per usage and/or terms. By using an A La Carte Service, you agree to pay the fees and any taxes incurred at the time of usage (A La Carte Fees and, together with Subscription Fees, the Paid Service Fees).',
  'Paid Service Fees may be paid by debit card, credit card, or deducted from your transaction proceeds. If you link a debit or credit card to your account, you authorize us to collect Paid Service Fees by debit from your linked debit card or charge to your linked credit card. Regardless of payment device, we reserve the right to collect Paid Service Fees by deduction from your transaction proceeds, the Balance (as defined in the Payment Terms) in your ePaisa Account or your linked bank account.',
  'Unless otherwise provided in a Subscription Service terms, If you cancel a Subscription Service, you will continue to have access to that Subscription Service through the end of your then current billing period, but you will not be entitled to a refund or credit for any Subscription Fee already due or paid. We reserve the right to change our Subscription Fee upon thirty (30) days advance notice. Your continued use of Subscription Services after notice of a change to our Subscription Fee will constitute your agreement to such changes.',
  '11. Termination',
  'We may terminate these General Terms or any Additional Terms, or suspend or terminate your ePaisa Account or your access to any Service, at any time for any reason. We will take reasonable steps to notify you of termination by email or at the next time you attempt to access your ePaisa Account. You may also terminate the General Terms and Additional Terms applicable to your ePaisa Account by deactivating your ePaisa Account at any time.',
  '12. Effect of Termination',
  'If these General Terms or your ePaisa Account is terminated or suspended for any reason: (a) the license and any other rights granted under these General Terms and any Additional Terms will end, (b) we may (but have no obligation to) delete your information and account data stored on our servers, and (c) we will not be liable to you or any third party for compensation, reimbursement, or damages for any termination or suspension of the Services, or for deletion of your information or account data. In addition to any payment obligations under the Payment Terms, the following sections of these General Terms survive and remain in effect in accordance with their terms upon termination:',
  '6.   (Your Content)',
  '7.   (Copyright and Trademark Infringement)',
  '12.  (Effect of Termination)',
  '14 . (Ownership)',
  '15.  (Indemnity)',
  '16.  (Representations and Warranties)',
  '17.  (No Warranties)',
  '18.  (Limitation of Liability and Damages) ',
  '19.  (Third Party Products)',
  '20.   (Disputes)',
  '21.  (Binding Individual Arbitration)',
  '22.  (Governing Law)',
  '23.  (Limitation on Time to Initiate a Dispute)',
  '24.  (Assignment)',
  '25.  (Third Party Service and Links to Other Web Sites)',
  '26.  (Other Provisions)',
  '13. Your License',
  'We grant you a limited, non-exclusive, revocable, non-transferable, non-sub-licensable license to use the software that is part of the Services, as authorized in these General Terms. We may make software updates to the Services available to you, which you must install to continue using the Services. Any such software updates may be subject to additional terms made known to you at that time.',
  '14. Ownership',
  'We reserve all rights not expressly granted to you in these General Terms. We own all rights, title, interest, copyright and other worldwide Intellectual Property Rights (as defined below) in the Services and all copies of the Services. These General Terms do not grant you any rights to our trademarks or service marks.',
  'For the purposes of these General Terms, Intellectual Property Rights means all patent rights, copyright rights, mask work rights, moral rights, rights of publicity, trademark, trade dress and service mark rights, goodwill, trade secret rights, and other intellectual property rights that may exist now or come into existence in the future, and all of their applications, registrations, renewals and extensions, under the laws of any state, country, territory or other jurisdiction.',
  'You may submit comments or ideas about the Services (Ideas). By submitting any Idea, you agree that your disclosure is gratuitous, unsolicited, and without restriction, that it will not place us under any fiduciary, confidentiality or other obligation, and that we are free to use the Idea without any additional compensation to you, and/or to disclose the Idea on a non-confidential basis or otherwise to anyone.',
  '15. Indemnity',
  'You will indemnify, defend, and hold us and our processors (and our respective employees, directors, agents, affiliates and representatives) harmless from and against any and all claims, costs, losses, damages, judgments, tax assessments, penalties, interest, and expenses (including without limitation reasonable attorneys fees) arising out of any claim, action, audit, investigation, inquiry, or other proceeding instituted by a person or entity that arises out of or relates to: (a) any actual or alleged breach of your representations, warranties, or obligations set forth in these General Terms or any Additional Terms; (b) your wrongful or improper use of the Services; (c) your violation of any third-party right, including without limitation any right of privacy, publicity rights or Intellectual Property Rights; (d) your violation of any law, rule or regulation of India, Singapore or any other country; and (e) any other party access and/or use of the Services with your unique name, password or other appropriate security code.',
  '16. Representations and Warranties',
  'You represent and warrant to us that: (a) you are at least eighteen (18) years of age; (b) you are eligible to register and use the Services and have the right, power, and ability to enter into and perform under these General Terms; (c) any information you provide in connection with the Services, including your business name, accurately and truthfully represents your business or personal identity under which you sell goods and services; (d) you and all transactions initiated by you will comply with all federal, state, and local laws, rules, and regulations applicable to you and/or your business, including the Health Insurance Portability and Accountability Act (HIPAA); (e) you will not use the Services, directly or indirectly, for any fraudulent undertaking or in any manner so as to interfere with the operation of the Services; and (f) your use of the Services will be in compliance with these General Terms and applicable Additional Terms.',
  '17. No Warranties',
  'The use of ePaisa in sections 17 and 18 means ePaisa, its processors, its suppliers, and its licensors (and their respective subsidiaries, affiliates, agents, directors, and employees).',
  'The services are provided as is without representation or warranty, whether it is express, implied, or statutory. Without limiting the foregoing, ePaisa specifically disclaims any implied warranties of merchantability, fitness for a particular purpose, or non-infringement.',
  'ePaisa does not warrant or guarantee that the services are accurate, reliable or correct; that the services will meet your requirements; that the services will be available at any particular time or location, uninterrupted, error-free, without defect or secure; that any defects or errors will be corrected; or that the services are free of viruses or other harmful components.',
  'ePaisa does not warrant, endorse, guarantee, or assume responsibility for any product or services advertised or offered by a third party. ePaisa does not have control of, or liability for, goods or services that are paid for using the Services.',
  '18. Limitations of Liability and Damages',
  'To the maximum extent permitted by applicable law, in no event will ePaisa be liable for any direct, indirect, punitive, incidental, special, consequential, or exemplary damages, including without limitation damages for loss of profits, goodwill, use, data, or other intangible losses, that result from the use of, inability to use, or unavailability of the service. In all cases, ePaisa will not be liable for any loss or damage that is not reasonably foreseeable.',
  'Under no circumstances will ePaisa be responsible for any damage, loss, or injury resulting from hacking, tampering, or other unauthorized access or use of the services or your ePaisa account, or the information contained therein.',
  'To the maximum extent permitted by applicable law, the total liability of ePaisa is limited to the greater of (a) the amount of fees earned by us in connection with your use of the services during the three (3) month period immediately preceding the event giving rise to the claim for liability, or (b) Indian rupees rs. 500.',
  'This limitation of liability section applies whether the alleged liability is based on contract, tort, negligence, strict liability, or any other basis, even if ePaisa has been advised of the possibility of such damage. The foregoing limitation of liability will apply to the fullest extent permitted by law in the applicable jurisdiction.',
  '19. Third Party Products',
  'All third party hardware and other products included or sold with the Services are provided solely according to the warranty and other terms specified by the manufacturer, who is solely responsible for service and support for its product. For service, support, or warranty assistance, you should contact the manufacturer directly. ePaisa MAKES NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR IMPLIED, WITH RESPECT TO SUCH THIRD PARTY PRODUCTS, AND EXPRESSLY DISCLAIMS ANY WARRANTY OR CONDITION OF MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR A PARTICULAR PURPOSE.',
  '20. Disputes',
  '‘Disputes’ are defined as any claim, controversy, or dispute between you and ePaisa, its processors, suppliers or licensors (or their respective affiliates, agents, directors or employees), including any claims relating in any way to these General Terms, any Additional Terms, or the Services, or any other aspect of our relationship.',
  '21. Binding Individual Arbitration',
  'You and ePaisa agree to arbitrate any and all Disputes by a neutral arbitrator who has the power to award the same damages and relief that a court can. Any arbitration under these general terms will only be on an individual basis; class arbitrations, class actions, private attorney general actions, representative actions and consolidation with other arbitrations are not permitted. You waive any right to have your case decided by a jury and you waive any right to participate in a class action against ePaisa. If any provision of this arbitration agreement is found unenforceable, the unenforceable provision will be severed, and the remaining arbitration terms will be enforced (but in no case will there be a class or representative arbitration). All Disputes will be resolved finally and exclusively by binding individual arbitration with a single arbitrator administered by Indian Arbitration Act at New Delhi, India Consumer claimants (individuals whose transaction is intended for personal, family, or household use) may elect to pursue their claims in their local small-claims court rather than through arbitration so long as their matter remains in small claims court and proceeds only on an individual (non-class or non-representative) basis. If you are a consumer bringing a claim relating to personal, household, or family use, any arbitration hearing will occur in New Delhi, India. Otherwise, any arbitration hearing will occur in New Delhi, India, or another mutually agreeable location. The arbitrator award will be binding on the parties and may be entered as a judgment in any court of competent jurisdiction. We will pay the arbitration fees due to the India Arbitration Act and Association for individual arbitrations brought in accordance with this section. If you prevail on any claim for which you are legally entitled to attorney fees, you may seek to recover those fees from the arbitrator. For any claim where you are seeking relief, we will not seek to have you pay our attorney fees, even if fees might otherwise be awarded, unless the arbitrator determines that your claim was frivolous. For purposes of this arbitration provision, references to you and ePaisa also include respective subsidiaries, affiliates, agents, employees, predecessors, successors and assigns as well as authorized users or beneficiaries of the Services. Subject to and without waiver of the arbitration provisions above, you agree that any judicial proceedings (other than small claims actions in consumer cases) will be brought in and you hereby consent to the exclusive jurisdiction and venue in the state courts in the of New Delhi, India.',
  '22. Governing Law',
  'These General Terms and any Dispute will be governed by New Delhi, India law and/or applicable Arbitration Act as applied to agreements entered into and to be performed entirely within New Delhi, India, without regard to its choice of law or conflicts of law principles.',
  '23. Limitation on Time to Initiate a Dispute',
  'Any action or proceeding by you relating to any Dispute must commence within one year after the cause of action accrues.',
  '24. Assignment',
  'These General Terms, and any rights and licenses granted hereunder, may not be transferred or assigned by you and any attempted transfer or assignment will be null and void.',
  '25. Third Party Services and Links to Other Web Sites',
  'You may be offered services, products and promotions provided by third parties and not by ePaisa (Third Party Services). If you decide to use Third Party Services, you will be responsible for reviewing and understanding the terms and conditions for these services. We are not responsible for the performance of any Third Party Services. The Services may contain links to third party websites. The inclusion of any website link does not imply an approval, endorsement, or recommendation by ePaisa. Such third party websites are not governed by these General Terms. You access any such website at your own risk. We expressly disclaim any liability for these websites. When you use a link to go from the Services to a third party website, our Privacy Policy is no longer in effect. Your browsing and interaction on a third party website, including those that have a link in the Services is subject to that website own terms, rules and policies.',
  '26. Other Provisions',
  'These General Terms, and any applicable Additional Terms or Policies, are a complete statement of the agreement between you and ePaisa regarding the Services. In the event of a conflict between these General Terms and any other ePaisa agreement or Policy, these General Terms will prevail and control the subject matter of such conflict. If any provision of these General Terms or any Additional Term is invalid or unenforceable under applicable law, then it will be changed and interpreted to accomplish the objectives of such provision to the greatest extent possible under applicable law, and the remaining provisions will continue in full force and effect. These General Terms do not limit any rights that we may have under trade secret, copyright, patent, or other laws. No waiver of any term of these General Terms will be deemed a further or continuing waiver of such term or any other term.',
];

class _AgreementDialogState extends State<AgreementDialog> {
  bool showModal = true;
  bool searchMode = false;
  String query;
  @override
  void initState() {
    super.initState();
  }

  void closeModal() {
    Navigator.of(context).pop();
    setState(() {
      showModal = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context).size).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context).size).hp;
    var tablet = isTablet(MediaQuery.of(context));
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: Container(
        alignment: Alignment.center,
        width: wp(100),
        height: hp(100),
        child: !showModal
            ? Container()
            : Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showModal = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: wp(100),
                      height: hp(100),
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        width: (tablet ? wp(70) : wp(95)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(hp(1.5))),
                                  child: ButtonBorder(
                                    callback: () {
                                      widget.selectOption(false);
                                      closeModal();
                                    },
                                    title: eptxt('decline').toUpperCase(),
                                    fontSize: tablet ? hp(2.4) : hp(2.1),
                                    fontWeight: FontWeight.w700,
                                    borderWidth: 1.2,
                                    paddingVertical: tablet ? hp(2.8) : hp(1.8),
                                  )),
                            ),
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(hp(1.5))),
                                child: ButtonGradient(
                                  callback: () {
                                    widget.selectOption(true);
                                    closeModal();
                                  },
                                  title: eptxt('accept').toUpperCase(),
                                  fontSize: tablet ? hp(2.4) : hp(2.1),
                                  fontWeight: FontWeight.w700,
                                  paddingVertical: tablet ? hp(3) : hp(2),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: (tablet ? wp(70) : wp(95)),
                        height: tablet ? hp(80) : hp(85),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(),
                            ),
                            Container(
                              width: (tablet ? wp(70) : wp(95)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: tablet ? wp(2) : wp(4)),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(hp(1.5)),
                                    bottomRight: Radius.circular(hp(1.5))),
                                color: AppColors.PrimaryWhite,
                              ),
                              child: ScrollConfiguration(
                                behavior: RemoveOverScrollGlow(),
                                child: ListView(children: <Widget>[
                                  SizedBox(
                                    height: hp(1.8),
                                  ),
                                  Center(
                                    child: Text(
                                      eptxt('sellers_agreement'),
                                      style: TextStyle(
                                          fontSize: tablet ? hp(3) : hp(2.4),
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.PrimaryBlue),
                                    ),
                                  ),
                                  SizedBox(
                                    height: hp(1.4),
                                  ),
                                  ...texts
                                      .map((text) => Paragraph(text))
                                      .toList(),
                                ]),
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

class Paragraph extends StatelessWidget {
  const Paragraph(
    this.text,
  );

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: hp(1.5),
            fontWeight: FontWeight.w600,
            color: AppColors.TermsGray.withOpacity(0.8),
          ),
        ),
        SizedBox(
          height: hp(2.4),
        )
      ],
    );
  }
}
