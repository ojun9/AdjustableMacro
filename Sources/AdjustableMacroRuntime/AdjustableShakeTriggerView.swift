import SwiftUI

#if DEBUG
public struct AdjustableShakeTriggerView: UIViewControllerRepresentable {
    public init() {}

    public func makeUIViewController(context: Context) -> ShakeDetectingViewController {
        .init()
    }

    public func updateUIViewController(_ uiViewController: ShakeDetectingViewController, context: Context) {}
}

public class ShakeDetectingViewController: UIViewController {
    private var isPresented = false

    public override var canBecomeFirstResponder: Bool { true }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }

    public override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else { return }
        guard !isPresented else { return }

        guard presentedViewController == nil else { return }

        isPresented = true
        let vc = UIHostingController(rootView: AdjustablePanelView())
        vc.modalPresentationStyle = .pageSheet
        vc.view.backgroundColor = .clear
        present(vc, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isPresented = false
            }
        }
    }
}
#endif
